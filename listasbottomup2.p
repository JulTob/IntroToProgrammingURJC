/*		Julio Toboso
*		Programa de testeo
*		se utiliza appen como entrada al final
*		y entrar como entrada al principio 
*/


program bottomup;


types:									/*Tipos para frase*/
	
	TipoPtrFrase = ^TipoNdFrase;
	
	TipoNdFrase = record
	{
		l	: char; 				 /* l de letra           */
		pos : int;					/* posición en la frase */
		psig: TipoPtrFrase; 	   /* puntero a siguiente  */
		
	};
	
	TipoFrase = record 
	{
		pinicio : TipoPtrFrase; 	 /* puntero a inicio de frase */
		pfin 	: TipoPtrFrase;		/* puntero al final de frase */
	};


types:									/*Tipos para Texto*/
	
	TipoPtrTexto = ^TipoNdTexto;
	
	TipoNdTexto = record
	{
		frs  : TipoFrase;			  /* frase                */
		long : int;					 /* longitud de la frase */
		psig : TipoPtrTexto;		/* puntero a siguiente  */		
	};
	
	TipoTexto = record
	{
		pcomienzo : TipoPtrTexto ;	 /* Puntero a inicio de Texto */
		pcierre	  : TipoPtrTexto ;	/* Puntero a ultima frase    */
	};

function iniciarfrase(): TipoFrase
	nuevafrase : TipoFrase;
{
	nuevafrase.pinicio = nil;
	nuevafrase.pfin    = nil;
	return nuevafrase;
}

procedure appendletra ( ref frs: TipoFrase, l: char)
	pletra : TipoPtrFrase;
{
	new(pletra);
	pletra^.l    = l;
	pletra^.psig = nil;
	if (frs.pinicio==nil) 
	{
		frs.pinicio = pletra;	
		pletra^.pos = 1;
	} else {
		pletra^.pos = frs.pfin^.pos +1;
		frs.pfin^.psig = pletra;
	}
	frs.pfin = pletra;

	
}


procedure escribefrase ( frs : TipoFrase )
	pletra : TipoPtrFrase;
{
	pletra = frs.pinicio;
	while (pletra != nil)
	{
		write ( pletra^.l);
		/*	write (pletra^.pos);	/*Para testeos*/
		pletra = pletra^.psig;
	}
	writeeol();

}

procedure limpiafrase ( ref frs : TipoFrase )
	paux : TipoPtrFrase;
{
	while (frs.pinicio != nil)
	{
		paux = frs.pinicio;
		frs.pinicio = frs.pinicio^.psig;
		dispose(paux);
	}
	
}

procedure leefrase ( ref frs : TipoFrase )
	c : char;
{
	do{
		peek (c);
		if (c != Eol and c != Eof)
		{
			appendletra (frs,c);
			read(c);
		}
	}while (c != Eol and c != Eof);
	
}

function longitudfrase ( frs : TipoFrase ) : int
{
	return frs.pfin^.pos;
}


function inciartexto(): TipoTexto
	nuevotexto : TipoTexto;
{
	nuevotexto.pcomienzo = nil;
	nuevotexto.pcierre   = nil;
	return nuevotexto;
}

procedure entrarfrasevacia ( ref txt : TipoTexto)
	pauxtxt : TipoPtrTexto; /*Puntero auxiliar de texto*/
{
	new(pauxtxt);
	pauxtxt^.frs  = iniciarfrase();
	pauxtxt^.long = 0;
	pauxtxt^.psig = txt.pcomienzo;
	txt.pcomienzo = pauxtxt;
}

procedure entrarfrase ( ref txt : TipoTexto)
 	pauxtxt : TipoPtrTexto;
{
	new(pauxtxt);
	pauxtxt^.frs  = iniciarfrase();
	leefrase( pauxtxt^.frs );
	pauxtxt^.long = longitudfrase(pauxtxt^.frs);
	pauxtxt^.psig = txt.pcomienzo;
	txt.pcomienzo = pauxtxt;

}


procedure leertexto( ref txt : TipoTexto )
	c : char; 
{
	do{
		peek (c);
		switch (c){
			case Eol :
				entrarfrasevacia (txt);
				readeol();
			case Eof :
				;
			default:
				entrarfrase (txt);	
			}
		} while( c != Eof);
}

procedure escribetexto( texto : TipoTexto)
	pauxtxt : TipoPtrTexto ;
{
		pauxtxt = texto.pcomienzo;
		while( pauxtxt != nil )
		{
			escribefrase( pauxtxt^.frs );
			pauxtxt = pauxtxt^.psig;
		}		
}

procedure limpiatexto ( ref texto : TipoTexto)
	pauxtxt : TipoPtrTexto;
{
	while (texto.pcomienzo != nil)
	{
		pauxtxt = texto.pcomienzo;
		texto.pcomienzo = texto.pcomienzo^.psig;
		limpiafrase( pauxtxt^.frs );
		dispose( pauxtxt );
	}
}

procedure lamayor( texto : TipoTexto )
	pauxtxt : TipoPtrTexto 	;
	auxfrs	: TipoFrase		;
	i		: int			;
	
{
	if (texto.pcomienzo != nil)
	{
		pauxtxt = texto.pcomienzo;
		i=0;
		
		do{	
			if ( i < pauxtxt^.long)
			{
				i = pauxtxt^.long;
				auxfrs = pauxtxt^.frs ;
			};
			pauxtxt = pauxtxt^.psig;
			
		}while( pauxtxt != nil );
		
		escribefrase( auxfrs );
	};
	
}	

procedure main()
	frase : TipoFrase;
	texto : TipoTexto;
{
	texto = inciartexto();
	
	leertexto(texto);
	
	escribetexto(texto);
	
	lamayor(texto);
	
	limpiatexto (texto);

}
