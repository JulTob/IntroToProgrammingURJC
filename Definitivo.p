/*		Julio Toboso
*		Programa de practica 2015 - 2016 
*		Juego de Cuatro En Raya
* 
*		Versión definitiva
*/

program cuatroenraya ;

types:	

	TipoJugador = (Pino, Cristal, Vacio);
	
	
consts:
	NJugadores= 2;
	PrimerJug = Pino;
	UltimoJug = Cristal;
	AltoColumnas =    9;
	NumeroColumnas = 10;
	

		
	
		
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

	
	
	
	TipoJugada = record
	{
		Jugador: 	TipoJugador; 				     
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
	default:
		return'.';
	
	}
	
	
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









procedure printatablero ( tablero : TipoTablero)
	i : TipoAltura;
	j : TipoQueColumna;
{
	for (i = 1 , i <= AltoColumnas ) 
	{
		write('*');
		for ( j = 1, j <= NumeroColumnas)
		{
		
		write ( simb ( tablero.pos[j][i]));
		
		
		
		
		}
		writeln('*');

	}
}


procedure main()
{
	printatablero( nuevotablero() );
	
	
	
}	
