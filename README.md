# Fireball and Bolide Reports: Analiza zjawisk Bolidów i Meteorów
Projekt został zrealizowany w ramach zaliczenia przedmiotu **Programowanie w SAS** na Politechnice Gdańskiej. Jego celem jest przeprowadzenie efektywnej analizy danych i przedstawienie wyników w formie wizualizacji.
## Zbiór danych 
"Fireball And Bolide Reports" pochodzi z publicznego archiwum danych NASA
Open Data Portal: https://data.nasa.gov/dataset/fireball-and-bolide-reports
i opiera się na oficjalnych danych publikowanych przez NASA CNEOS.
## Wyniki analizy
**1. Rozkład rozbłysków w czasie**

Procedura **freq** tworzy tabelę krzyżową, przedstawiającą liczbę rozbłysków z podziałem na miesiące i lata.
<img width="575" height="267" alt="freqdata" src="https://github.com/user-attachments/assets/ee3cb4b9-678c-415c-a217-252d646cec72" />

Wizualizacja powyższej tabeli w formie wykresu słupkowego.
<img width="637" height="476" alt="czas" src="https://github.com/user-attachments/assets/9e66ef16-c520-423d-a5d2-f83dda2c9e7a" />

**2. Procentowy rozkład wysokości rozbłysków**

Wykres przedstawia histogram procentowego rozkładu wysokości, na jakich dochodziło do rozbłysków bolidów, wraz z nałożoną na niego krzywą teoretycznego rozkładu normalnego. 

<img width="635" height="477" alt="histogram" src="https://github.com/user-attachments/assets/7c17615b-b27d-4398-9108-c8b22d4d7a82" />

**3. Zależność między prędkością, a energią kinetyczną**

Wykres przedstawia rozrzut punktowy obrazujący relację pomiędzy prędkością wejścia obiektu w atmosferę (w km/s), a wyzwoloną przez niego energią kinetyczną (w kilotonach, kt). 

<img width="632" height="473" alt="pkt" src="https://github.com/user-attachments/assets/ebbc74f1-481a-4d20-8283-200a5365612d" />


**4. Rozkład geograficzny rozbłysków**

Tabela krzyżowa wygenerowana procedurą freq dzieli zaobserwowane zjawiska na odpowiednie ćwiartki globu.
<img width="419" height="188" alt="freqziemia" src="https://github.com/user-attachments/assets/4f619d20-f96e-4981-b240-463ffa588bc9" />

Wykres bąbelkowy nakłada punkty na osie odpowiadające długości (oś X) i szerokości (oś Y) geograficznej, tworząc uproszczoną mapę świata. Wielkość każdego bąbelka zależy od wyzwolonej energii kinetycznej.

<img width="633" height="477" alt="bubl" src="https://github.com/user-attachments/assets/c220a419-d164-4d35-bf34-8cd9359d8610" />

## Wnioski z analizy
* Najwięcej rozbłysków (33) zaobserwowano w 2014 roku.
* Większość meteorów spala się w Stratosferze (warstwie atmosfery ziemskiej) na wysokościach 20km - 40km. Krzywa rozkładu normalnego nie odzwierciedla faktycznego kształtu histogramu. Wykres
posiada dwa szczyty - na wysokościach 22km oraz 38km. Kształt wykresu nie jest dopasowany do krzywej w jej centrum, gdzie oczekuje największej ilości obserwacji - w rzeczywistości na wysokości 32 km zaobserwowano tylko jeden rozbłysk.
* Na wykresie punktowym zależności prędkości od energii kinetycznej możemy zaobserwować brak 
zależności kwadratowej prawdopodobnie przez brak danej prędkości dla większości obserwacji. Widoczny jest jeden punkt odstający przy prędkości 18 km/s, który uwolnił aż 440 kt energii kinetycznej.
* Wykres bąbelkowy dowodzi, że nie ma określonej zasady, co do miejsca występowania rozbłysków.
* Odstający punkt z wykresu punktowego zależności prędkości od energii kinetycznej to Meteor Czelabiński, którego eksplozja miała miejsce nad Rosją (co potwierdza wykres bąbelkowy).


