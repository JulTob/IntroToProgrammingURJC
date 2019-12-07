	TipoListaJug = ^TipoNdJug;

	TipoNdJug = record
	{
		barco: TipoBarco;
		sig: TipoListaJug;
	};

	TipoJug = record
	{
		prim: TipoListaJug;
		ult: TipoListaJug
	};

	TipoJugs = array[1..MaxJugs] of TipoJug;

	TipoListaMovs=^TipoNdMovs;
	
	TipoNdMovs = record
	{
		mov: TipoCasilla;
		sig: TipoListaMovs;
	};

	TipoMovs = record
	{
		primero: TipoListaMovs;
		ultimo: TipoListaMovs
	}

	TipoJuego = record
	{
		jugs: TipoJugs;
		movs: TipoMovs;
		};

consts:
	CasillaNula= TipoCasilla(

function esblanco(c:char):bool
{
	return c==' ' or c==Tab or c==Eol;
}

procedure saltarblancos (ref f: file)
{
	do{
		fpeek(f,c);
		switch(c){
		case Eol:
			freadeol(f);
		case Eof:
			; 	/*done*/
		default:
			if (esblanco(c)){
				fread(f,c);
				}
			}while (not feof(f) and esblanco(c));
	
}

procedure leercol( ref f: file, ref col: TipoCol, ref ok: bool)
	c: char;
{	/*}*/
	saltarblancos(f);
	ok= False;
	if (not feof(f)){
		fpeek(f,c);
		if (c>='A' and c<= MaxCol){
			fread(f,col);
			ok=True
			}
		}
}

procedure leerfila (ref f:file, ref fila: TipoFils, ref ok: bool)
	c:char;
{
	fila=1;
	saltarblancos(f);
	ok= False;
	if (not feof(f)){
		fpeek(f,c);
		if(c>='0' and c<='9'){
			fread(f, fila);
			ok = True;	
}	

procedure leerjug (ref f: file, ref
{

}	
	
	
procedure main ()
	jug: TipoJug;
	ok:bool;
{
	do{
		leercasilla(stdin, b, ok);
		if (ok){
			escrcasilla(b)
			writeeol();	
}			
