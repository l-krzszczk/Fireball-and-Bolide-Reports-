
filename zbior "/home/u64463035/Projekt/Fireball_And_Bolide_Reports_rows.csv";
libname projekt "/home/u64463035/Projekt";

/* Import zbioru danych */
proc import file=zbior dbms=csv out=projekt.Poczatkowe_dane replace;
	getnames=yes;
run;

title "Początkowy zbiór 'Fireball And Bolide Reports'";

proc print data=projekt.Poczatkowe_dane noobs;
run;


/* Analiza zmiennych początkowego zbioru */
proc contents data=projekt.Poczatkowe_dane;
run;

/* Zmiana nazw kolumn */
data projekt.Poczatkowe_dane_pl;
	set projekt.Poczatkowe_dane;
	rename "Date/Time - Peak Brightness (UT)"n=Data_czas 
		"Latitude (Deg)"n=Szerokosc_geo "Longitude (Deg)"n=Dlugosc_geo 
		"Altitude (km)"n=Wysokosc_nad_ziemia "Velocity (km/s)"n=Predkosc 
		"Velocity Components (km/s): vx"n=Predkosc_wektor_vx 
		"Velocity Components (km/s): vy"n=Predkosc_wektor_vy 
		"Velocity Components (km/s): vz"n=Predkosc_wektor_vz 
		"Total Radiated Energy (J)"n=Energia_wypromieniowana 
		"Calculated Total Impact Energy ("n=Energia_kinetyczna;
run;

title "Początkowy zbiór ze zmionionymi nazwami kolumn";

proc print data=projekt.Poczatkowe_dane_pl noobs;
run;

/* Dodanie etykiet */
data projekt.Poczatkowe_dane_pl;
	set projekt.Poczatkowe_dane_pl;
	label Data_czas="Date/Time - Peak Brightness (UT)" 
		Szerokosc_geo="Latitude (Deg)" Dlugosc_geo="Longitude (Deg)" 
		Wysokosc_nad_ziemia="Altitude (km)" Predkosc="Velocity (km/s)" 
		Predkosc_wektor_vx="Velocity Components (km/s): vx" 
		Predkosc_wektor_vy="Velocity Components (km/s): vy" 
		Predkosc_wektor_vz="Velocity Components (km/s): vz" 
		Energia_wypromieniowana="Total Radiated Energy (J)" 
		Energia_kinetyczna="Calculated Total Impact Energy (kt)";
run;

proc contents data=projekt.Poczatkowe_dane_pl;
	label;
run;

/* Sortowanie i usunięcie duplikatów */
proc sort data=projekt.Poczatkowe_dane_pl nodup;
	by _all_;
run;

title "Statystyki opisowe dla zmiennych numerycznych";

proc means data=projekt.Poczatkowe_dane_pl maxdec=3 n nmiss min max mean std;
	var Wysokosc_nad_ziemia Predkosc Energia_wypromieniowana Energia_kinetyczna;
	label;
run;

/* Wyodrębnienie roku ze zmiennej Data_czas */
data projekt.Poczatkowe_dane_pl;
	set projekt.Poczatkowe_dane_pl;
	Data_rok=Datepart(Data_czas);
	format Data_rok YEAR4.;
run;

/* Wyodrębnienie miesiąca ze zmiennej Data_czas */
data projekt.Poczatkowe_dane_pl;
	set projekt.Poczatkowe_dane_pl;
	Data_miesiac=Datepart(Data_czas);
	format Data_miesiac MONNAME3.;
run;

title "Rozkład częstotliwości występowania rozbłysków";

proc freq data=projekt.Poczatkowe_dane_pl;
	tables Data_rok*Data_miesiac / nocum nopercent nocol norow;
run;

/* Wyodrębnienie informacji o pólkuli na której nastąpił rozbłysk */
data projekt.Poczatkowe_dane_pl;
	set projekt.Poczatkowe_dane_pl;
	Polkula_NS=compress(Szerokosc_geo, '.0123456789');
	Polkula_EW=compress(Dlugosc_geo, '.0123456789');
run;

title "W których miejscach na Ziemi najczęściej występowały rozbłyski";

proc freq data=projekt.Poczatkowe_dane_pl order=freq;
	tables Polkula_NS*Polkula_EW / nocum nopercent nocol norow;
run;


data projekt.Poczatkowe_dane_pl;
	set projekt.Poczatkowe_dane_pl;
	miesiac_num=MONTH(Data_miesiac);
	format miesiac_num BEST12.;
	label miesiac_num = "Miesiąc";
run;

ods graphics on / imagemap=on;
title "Liczba zarejestrowanych bolidów w latach";

proc sgplot data=projekt.Poczatkowe_dane_pl;
	vbar data_rok /group=miesiac_num groupdisplay=cluster;
	xaxis label="Rok";
	yaxis label="Liczba rozbłysków" grid;
run;

title "Procentowy rozkład wysokości rozbłysków";

proc sgplot data=projekt.Poczatkowe_dane_pl;
	histogram wysokosc_nad_ziemia / datalabel fillattrs=(color=CXF6F09F) 
		binwidth=2;
	density wysokosc_nad_ziemia / lineattrs=(color=CXD96868);
	xaxis label="Wysokość nad Ziemią (km)" values=(0 to 72 by 6);
	yaxis label="Odsetek rozbłysków" values=(0 to 20 by 5) grid;
run;

title "Zależność między prędkośćią bolidu, a energią kinetyczną";

proc sgplot data=projekt.Poczatkowe_dane_pl;
	scatter x=predkosc y=Energia_kinetyczna /markerattrs=(symbol=CircleFilled 
		size=9 color=CXFF0000);
	xaxis label="Prędkość bolidu (km/s)";
	yaxis label="Eneria kinetyczna (kt)" grid;
run;

data projekt.wspolrzedne;
	set projekt.Poczatkowe_dane_pl;
	szer_liczba=input(compress(szerokosc_geo, 'NSWE'), best12.);

	if index (szerokosc_geo, 'S')>0 then
		szer_num=szer_liczba*-1;
	else
		szer_num=szer_liczba;
	dlug_liczba=input(compress(dlugosc_geo, 'NSWE'), best12.);

	if index (dlugosc_geo, 'W')>0 then
		dlug_num=dlug_liczba*-1;
	else
		dlug_num=dlug_liczba;
run;

proc sgplot data=projekt.wspolrzedne;
	bubble x=dlug_num y=szer_num size=energia_kinetyczna / 
		fillattrs=(color=CXA2CB8B);
	xaxis label="Długość geograficzna" grid;
	yaxis label="Szerokość geograficzna" grid;
run;