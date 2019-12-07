/*		Julio Toboso
*		Programa de practica 2015 - 2016 
*		Juego de Cuatro En Raya
* 
*/
program cuatroenraya ;


/*****  Tipos *****/

types:											
	TipoJugador = (Pino, Cristal, Vacio);
	
consts:
	PrimerJug 		= Pino;
	UltimoJug 		= Cristal;
	
	AltoColumnas 	= 9;
	NumeroColumnas 	= 10;

types:
	TipoQueColumna 	= int 1..NumeroColumnas;
	TipoAlturas		= int 1..AltoColumnas;
	
	TipoPosicion	= record
	{
		columna	: TipoQueColumna;
		altura	: TipoAlturas;
	};
	TipoCasilla = record
	{
		pos 		: TipoPosicion;
		contenido	: TipoJugador;
	};
	
types: 
	TipoFichaNoGana = char 'a'..'z';
	TipoFichaGana	= char	'A'..'Z';
	TipoFicha	= record
	{
		nogana 	: TipoFichaNoGana;
		gana	: TipoFichaGana;
	};
	TipoColumna = array[1..NumeroColumnas] of TipoFicha;
	TipoTablero = array[1..NumeroColumnas] of TipoColumna;
		
types: 
	TipoPtJuego = ^TipoNdJuego;
	TipoNdJuego = record
	{
		jugador 	: TipoJugador;
		movimiento	: TipoQueColumna;
		psiguiente	: TipoPtJuego;
	};
	TipoJuego = record
	{
		ptprimera	: TipoPtJuego;
		ptultima	: TipoPtJuego;
	};
	
/******   Acciones   ******/
	
function nuevojuego(): TipoJuego
	juego : TipoJuego;
{
	juego.ptprimera=nil;
	juego.ptultima=nil;
	return juego;
} 	

procedure limpiarjuego( juego : TipoJuego)
	pjuego : TipoPtJuego;
{
	while( juego.ptprimera != nil )
	{
		pjuego = juego.ptprimera;
		juego.ptprimera = juego.ptprimera^.psiguiente;
		dispose( pjuego );
	}
}

procedure anyadirtirada( juego : TipoJuego, pnueva : TipoPtJuego)

procedure leertirada ( ref jg : TipoJuego )
	pnuevatirada : TipoPtJuego;
	terminar : bool;
{
	while (not terminar)
	{
		new(pnuevatirada);
		writeln("jugador");
		read (pnuevatirada^.jugador);
		read (pnuevatirada^.movimiento);
		pnuevatirada^.siguiente= nil;
		anyadirtirada( juego, pnuevatirada );
		read(terminar);
}

procedure partida (ref jg : TipoJuego )
	sigue : bool;
{
	
	sigue = True;
	while ( sigue )
	{
		leertirada( jg );
		sigue = False;
	}
	
	printjuego (jg);
}

	
procedure main ()
	juego : TipoJuego;
{
 	juego= nuevojuego();
 writeln("Esto tira");
 	partida( juego);
 writeln("Esto tmbn tira");
 	limpiarjuego(juego);

}
