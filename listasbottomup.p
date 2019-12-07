/*		Julio Toboso
*		Programa de testeo
*
*/


program bottomup;

types:
	
	TipoPtrFrase = ^TipoNdFrase;
	
	TipoNdFrase = record
	{
		l: char; 				 	/* l de letra */
		pos : int;					/* posición en la frase */
		psig: TipoPtrFrase; 	   	/* puntero a siguiente*/
		
	};
	
	TipoFrase = record 
	{
		pinicio : TipoPtrFrase; 	/* puntero a inicio */
		pfin : TipoPtrFrase;		/* puntero al final */
	};

function iniciarfrase(): TipoFrase
	nuevafrase: TipoFrase;
{
	nuevafrase.pinicio= nil;
	nuevafrase.pfin= nil;
	return nuevafrase;
}

procedure appendletra ( ref frs: TipoFrase, l: char)
	pletra : TipoPtrFrase;
{
	new(pletra);
	pletra^.l = l;
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
		/*	write (pletra^.pos);	*/
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

procedure main()
	frase: TipoFrase;
{
	frase = iniciarfrase();
appendletra(frase, 's');
		appendletra(frase, 'o');
	appendletra(frase, 't');
		appendletra(frase, 'a');


	escribefrase(frase);
	limpiafrase(frase);
}
