/*		Julio Toboso
*		Programa de practica 2015 - 2016 
*		Juego de Cuatro En Raya
* 
*		BOTTOMUP
*/

program cuatroenraya ;

/*****  Tipos *****/

types:											
	TipoJugador = (Pino, Cristal, Vacio);
	
consts:
	PrimerJug 		= Pino;
	UltimoJug 		= Cristal;
	
	NumeroColumnas 	= 10;
	
types:
	TipoColumna 	= int 1..NumeroColumnas;	
	
types: 
	TipoJugada	= record 
	{
		jugador: TipoJugador;
		columna: TipoColumna;
	};
	
	
	
	
function esblanco(c:char):bool
{
	return c==' ' or c==Tab or c==Eol;
}

procedure saltarblancos (ref f: file)
	c: char;
{
	do{
		fpeek(f,c);
		switch(c)
		{
			case Eol:
				freadeol(f);
			case Eof:
				; 	/*done*/
			default:
				if (esblanco(c)){
					fread(f,c);
					}
				}
		}while ( not feof(f) and esblanco(c) );
	
}


	
procedure fleerjugador( f: file, ref jugador: TipoJugador)
	j:TipoJugador;
	c: char;
{	
	jugador=Vacio;
	do{
		peek(c);
		saltarblancos(f);
		fpeek(f, c);
		if (esblanco(c)){
			saltarblancos(f);
			} else {
				fread(f,jugador);
			};
		} while (jugador==Vacio);
}	
	
procedure leerjugada (f: file, ref jugada: TipoJugada)
{
	fleerjugador(f, jugada.jugador);
	fread(f, jugada.columna);

}
	
procedure main()
	jugada: TipoJugada;
{
	leerjugada(stdin,jugada);
	writeln(jugada.jugador);
	writeln(jugada.columna);

}
