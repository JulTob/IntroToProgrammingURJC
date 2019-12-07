/*
*	Cuatro En Raya
*	Practica de la asignatura Fundamentos de Programacion
*	1o
*
*		Autor: Julio Antonio Toboso García
*		Siguiendo el estilo de presentacion recomendado por Nemo
*
*
*/



program cuatroenraya ;

types:	

	TipoJugador = (Pino, Marmol, Acero, Cristal, Vacio);
	
	
consts:
	NJugadores= 4;
	PrimerJug = Pino;
	UltimoJug = Cristal;
	AltoColumnas =    9;
	NumeroColumnas = 12;
	XnR = 4; /*Cuanto (X) en Raya*/

		
	
		
types:	
	TipoAltura =  		int 1..AltoColumnas;
	TipoQueColumna = 	int 1..NumeroColumnas;
	
	TipoColumnas = array[1..AltoColumnas] 
						of TipoJugador;
	TipoPosicion = array [1..NumeroColumnas]   
						of TipoColumnas; /*[col][alt]*/
	TipoContadores = array[1..NumeroColumnas] 
						of TipoAltura;
	
	
	TipoTablero = record
	{
		pos: TipoPosicion;
		cont: TipoContadores;
	};

	TipoChequeo = array[1..XnR]
				of TipoJugador;
	
	TipoJugada = record
	{
		jugador: 	TipoJugador; 				     
		col  : 	TipoQueColumna;
	};
	TipoGanador = record
	{
		quien: TipoJugador;
		gana: bool;
	};
	
	TipoPtrJuego = ^TipoNdJuego;
	TipoNdJuego = record
	{
		jugada : 	TipoJugada	;
		tablero: 	TipoTablero;
		ganador : 	TipoGanador;
		psig: 		TipoPtrJuego; 	  
		
	};
	
	TipoJuego = record 
	{
		pinicio : TipoPtrJuego; 
		pultimo	: TipoPtrJuego;	
	};
	
	
function simb( j: TipoJugador) : char
{
	switch (j){
	case Pino:
		return 'p';
	case Cristal:
		return 'c';
	case  Marmol:
		return 'm';
	case  Acero:
		return 'a';
	default:
		return'.';
	
	}	
}
	

function iniciaganador() : TipoGanador
		gndr: TipoGanador;
{

	gndr.quien= Vacio;
	gndr.gana= False;
	return gndr;
}
	
function nuevoscontadores(): TipoContadores
	i: int;
	cntdr: TipoContadores;
{

	for (i=1, i<=NumeroColumnas)
	{
		cntdr[i]=1;
		
	};
	
	return cntdr;
	
}

function nuevopos(): TipoPosicion
	pos: TipoPosicion;
	i: int;
	j: int;
{

	for( i=1 , i<=NumeroColumnas)
	{
		for (j=1 , j<= AltoColumnas)
		{
			pos[i][j]=Vacio;
		}
	}
	
	return pos;
}
 
function nuevotablero() : TipoTablero
	tblr: TipoTablero;
{

	tblr.pos = nuevopos();
	tblr.cont= nuevoscontadores();
	return tblr;
}

 
function nuevojuego () : TipoJuego
	juego : TipoJuego;
	pjuego: TipoPtrJuego;
{

	juego.pinicio = nil;
	juego.pultimo = nil;
	
	new(pjuego);
	pjuego^.jugada.jugador=Vacio;
	pjuego^.jugada.col=1;
	pjuego^.tablero=nuevotablero();
	pjuego^.ganador= iniciaganador();
	pjuego^.psig=nil;
	
	juego.pinicio = pjuego;
	juego.pultimo = pjuego;
	
	return juego;
	
}
 
procedure limpiarjg (ref jg : TipoJuego)
	pjug : TipoPtrJuego;
{
	while (jg.pinicio != nil)
	{
		pjug = jg.pinicio;
		jg.pinicio= jg.pinicio^.psig;
		dispose(pjug);
	}
}

function esnumero(c:char):bool
{
	return c<='9' and c>='0';
}

function esletra(c:char):bool
{
	return (c>='a'and c<='z') or (c>='A'and c<='Z');
}

procedure leerjugador(ref jugador:TipoJugador ,ref error: bool)
	c:char;
{

		peek(c);
		if( esletra(c))
		{
			read(c);
			switch (c){
				case 'p':
					jugador=Pino;
				case 'P':
					jugador=Pino;
				case 'm':
					jugador=Marmol;
				case 'M':
					jugador=Marmol;
				case 'a':
					jugador=Acero;
				case 'A':
					jugador=Acero;
				case 'c':
					jugador=Cristal;
				case 'C':
					jugador=Cristal;
				default:
					error = True;
				}
		}else{
			error=True;	
		}
}
procedure leernumero( ref i: int)
	c: char;
	j:int;
{
	j=0;
	i=0;
	do{
		peek(c);
		if( esnumero(c))
		{
			read(c);
			j= int(c)-int('0');
			i=i*10+j;
		} 
		
	} while(esnumero(c) );
}



procedure leercolumna ( ref col: TipoQueColumna, ref error:bool)
	c:char;
	i:int;
	coltemp:int;
	para:bool;
{

	para=False;
	 peek(c);
	 if ( esnumero(c) )
	 {	
	 	leernumero(i);
	 	coltemp=i;
	 	if(coltemp>=1 and coltemp<=NumeroColumnas)
		{
	 		col=coltemp;
	 		para=True;
	 	}else{
			error=True;
		}	
	 } 
}

procedure saltarmorralla(ref error:bool)
	parar:bool;
	c:char;
{
	parar=False;
	do{
		peek(c);	
		if (esnumero(c))
		{
			parar=True;
		}else{
			switch(c){
			case Eol:
				readeol();
			case Eof:
				parar=True;
			default:
				read(c);
			}
		}
	}while(not parar);
}

procedure terminarmorralla(ref error:bool)
	parar:bool;
	c:char;
{
	parar=False;
	do{
		peek(c);	
		switch(c){
		case Eol:
			readeol();
			parar=True;
		case Eof:
			parar=True;
		default:
			read(c);
		}
	}while(not parar);
}

procedure leerjugada(ref jugada:TipoJugada ,ref error: bool)
	c: char;
	
{
	error=False;	
	jugada.jugador=Vacio;

	leerjugador(jugada.jugador, error);

	saltarmorralla(error);
	leercolumna(jugada.col, error);
				
	terminarmorralla(error);

	
	
	
}

function tablerodejugada (	tablero: TipoTablero
							, Jugador: TipoJugador
							, c: TipoQueColumna) : TipoTablero
	tblr:TipoTablero;
	altr: TipoAltura;
{
	tblr=tablero;
	altr= tablero.cont[c];
	if ( altr<=AltoColumnas and tblr.pos[c][AltoColumnas]==Vacio)
	{
		tblr.pos[c][altr]=Jugador;
	}
	return tblr;

	
}

function chequeoigual(chequeo: TipoChequeo): bool
	es: bool;
	i: int;
	jgdr: TipoJugador;
{
	es= True;
	jgdr= chequeo[1];
	for (i = 1, i <= XnR )
	{
		es= (jgdr==chequeo[i]) and es;
		
	}
	return es;
}

procedure cheqcol(ref gndr: TipoGanador , tblr: TipoTablero, c: int )
	chequeo: TipoChequeo;
	igual : bool;
	i : int;
	j: int;

{
	igual = False; 
	for ( i=1 , i<=(AltoColumnas-XnR))
	{
		for (j = 0 , j<XnR)
		{		
			chequeo[j+1]= tblr.pos[c][i+j];
			igual= chequeoigual(chequeo);
			if (igual and chequeo[1]!=Vacio)
			{
				gndr.gana = igual;
				gndr.quien = chequeo[1];
			}
		}
	}
}

function cheqvert ( tblr: TipoTablero): TipoGanador
	gndr: TipoGanador;
	c: TipoQueColumna;
{
	gndr=iniciaganador();
	for ( c = 1, c<= NumeroColumnas)
	{
		cheqcol( gndr, tblr, c );
	}
	return gndr;
}

procedure cheqfil(ref gndr: TipoGanador , tblr: TipoTablero, f: int )
	chequeo: TipoChequeo;
	igual : bool;
	i : int;
	j: int;
{
	igual = False; 
	for ( i=1 , i<=(NumeroColumnas-XnR))
	{
		for (j = 0 , j<XnR)
		{
			chequeo[j+1]= tblr.pos[i+j][f];
			igual= chequeoigual(chequeo);
			if (igual and chequeo[1]!=Vacio)
			{
				gndr.gana = igual;
				gndr.quien = chequeo[1];
			}
		}
	}
}

function cheqhor ( tblr: TipoTablero): TipoGanador
	gndr: TipoGanador;
	f: TipoAltura;
{
	gndr=iniciaganador();
	for ( f = 1, f<= AltoColumnas)
	{
		cheqfil( gndr, tblr, f );
	}
	return gndr;
}

procedure cheqds( ref gndr: TipoGanador, tblr: TipoTablero)
	chequeo: TipoChequeo;
	igual : bool;
	i: int;
	j: int;
	k: int;
	c: int;
	f: int; 
{
	igual = False; 
	for ( i=1 , i<=(NumeroColumnas-XnR))
	{
		for (j = 1 , j<=(AltoColumnas-XnR))
		{
			for (k = 0 , k<XnR)
			{	
				c=i+k;
				f=j+k;
				chequeo[k+1]= tblr.pos[c][f];
				igual= chequeoigual(chequeo);
				if (igual and chequeo[1]!=Vacio)
				{
					gndr.gana = igual;
					gndr.quien = chequeo[1];
				}
			}
		}
	}
}


procedure cheqdb( ref gndr: TipoGanador, tblr: TipoTablero)
	chequeo: TipoChequeo;
	igual : bool;
	i: int;
	j: int;
	k: int;
	c: int;
	f: int; 
{
	igual = False; 
	for ( i=XnR , i<=NumeroColumnas)
	{
		for (j=XnR , j<=AltoColumnas)
		{
			for (k = 0 , k<XnR)
			{	
				c=i-k;
				f=j-k;
				chequeo[k+1]= tblr.pos[c][f];
				igual= chequeoigual(chequeo);
				if (igual and chequeo[1]!=Vacio)
				{
					gndr.gana = igual;
					gndr.quien = chequeo[1];
				}
			}
		}
	}
}

function cheqdiag ( tblr: TipoTablero): TipoGanador
	gndr: TipoGanador;
{
	gndr=iniciaganador();
	cheqds( gndr, tblr);  /*Chequea cuando a la derecha sube*/
	cheqdb( gndr, tblr); /*Chequea cuando a la derecha baja*/
	return gndr;
}

function chequeaganador ( tblr: TipoTablero): TipoGanador
	gndr: TipoGanador;
{
	gndr=iniciaganador();
	
	gndr = cheqhor( tblr );
	
	if(gndr.gana == False )
	{
		gndr = cheqvert ( tblr );
		if(gndr.gana == False)
		{
			gndr= cheqdiag(tblr);
		}
	}
	
	
	return gndr;

}

procedure avanzacontador ( ref cntdr: TipoContadores, col: TipoQueColumna)
{
	if ( cntdr[col] < AltoColumnas )
	{
		cntdr[col]= cntdr[col]+1;
	}
}


procedure turno( ref juego: TipoJuego , ref error: bool)
	jugada : TipoJugada;
	pjuego: TipoPtrJuego;
{
	leerjugada(jugada, error);
	if(not error)
	{
		new(pjuego);
		pjuego^.jugada=jugada;
		pjuego^.tablero= tablerodejugada(juego.pultimo^.tablero
										, jugada.jugador
										, jugada.col);
		avanzacontador(pjuego^.tablero.cont, jugada.col);
		pjuego^.ganador= chequeaganador(pjuego^.tablero);
		pjuego^.psig=nil;
		juego.pultimo^.psig=pjuego;
		juego.pultimo=pjuego;
	}
}


procedure imprimetablero ( tablero : TipoTablero)
	i : TipoAltura;
	j : TipoQueColumna;
	gndr: TipoGanador;
	c: char;
	jgdr: TipoJugador;
{
	for (i = AltoColumnas , i >= 1 ) 
	{
		write('*');
		for ( j = 1, j <= NumeroColumnas)
		{
			gndr=chequeaganador(tablero);
			jgdr= tablero.pos[j][i];
			if (gndr.quien == jgdr and gndr.quien!=Vacio)
			{
				c= char( int(simb(jgdr))+int('A')-int('a') );
			} else {
				c = simb(jgdr);
			};
			write (c);
			
		
		}
		writeln('*');

	}
}

procedure escribejuego(juego: TipoJuego)
	gndr: TipoGanador;
	pjuego: TipoPtrJuego;
{
	gndr=chequeaganador(juego.pultimo^.tablero);
	pjuego=juego.pinicio;
	pjuego=pjuego^.psig;  /*Se salta el tablero vacio inicial*/
	
	while(pjuego!=nil)
	{
	
	
		if( gndr.quien==pjuego^.jugada.jugador)
		{
			writeln(pjuego^.jugada.jugador);
			writeln(pjuego^.jugada.col);
		}
		pjuego=pjuego^.psig;
	}
}

function tablas(  tablero : TipoTablero) : bool
	es : bool;
	j: int;
	i: int;
{
	es = True;
	for (i=1, i<=NumeroColumnas)
	{
		for (j=1, j<=AltoColumnas)
		{
			if (tablero.pos[i][j]==Vacio)
			{
				es= False;
			}
		}
	}
	return es;
}

procedure main ()
	juego: TipoJuego;
	para: bool;
	error: bool;
	ganador: TipoGanador;
{	
	juego = nuevojuego();	
	para = False;
	error= False;

	while( (not para) and (not error))
	{	
	
		turno (juego, error);
			
		if (error)
		{
			writeln("Error fatal");
			para=True;
		} else {
			imprimetablero(juego.pultimo^.tablero);

		}
		
		ganador=chequeaganador(juego.pultimo^.tablero);
		if (tablas (juego.pultimo^.tablero) )
		{
			para = True;
			writeln("Tablas");
		}
	para = ganador.gana;	
	}
	
	escribejuego(juego);
	
	limpiarjg(juego);
}
