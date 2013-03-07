# language: de
Funktionalität: Warenkörbe vergleichen
  Der User klickt auf "Vergleiche Anbieter" und die Warenkörbe werden verglichen und die Preisverläufe angezeigt

  Szenariogrundriss: Warenkorb mit 2 Artikeln
    Angenommen es gibt einen Warenkorb mit dem Artikel "Per Anhalter durch die Galaxis" und dem Artikel "Der Herr der Ringe - Die Gefährten"
    Und der Artikel "Per Anhalter durch die Galaxis" hat bei dem Provider "ebay.de" den Preis "12" und bei dem Provider "buch.de" den Preis "15"
    Und der Artikel "Der Herr der Ringe: Die Gefährten" hat bei dem Provider "ebay.de" den Preis "16" und bei dem Provider "buch.de" den Preis "10"
    Und ich bin auf der "Warenkorbansicht"
    Und wenn ich auf "Vergleiche Anbieter" klicke
    Dann sollte ich auf der "Warenkorbvergleichsseite" sein
    Und es wird "der Vergleich" angezeigt
    Und als Resultat wird "buch.de" angezeigt

 Szenariogrundriss: Warenkorb mit 0 Artikeln
    Angenommen es gibt einen Warenkorb ohne Artikel
    Und ich bin auf der "Warenkorbansicht"
    Wenn ich auf "Vergleiche Anbieter" klicke
    Dann sollte ich auf der "Warenkorbvergleichsseite" sein
    Und es wird "eine Fehlermeldung" angezeigt
    Und als Resultat wird "nichts" angezeigt

 Szenariogrundriss: Warenkorb mit 2 Artikeln
    Angenommen es gibt einen Warenkorb mit dem Artikel <Artikel1> und dem Artikel <Artikel2>
    Und der Artikel <Artikel1> hat bei dem Provider <Provider1> den Preis <Artikel1Provider1> und bei dem Provider <Provider2> den Preis <Artikel1Provider2>
    Und der Artikel <Artikel2> hat bei dem Provider <Provider1> den Preis <Artikel2Provider1> und bei dem Provider <Provider2> den Preis <Artikel2Provider2>
    Und ich bin auf der "Warenkorbansicht"
    Wenn wenn ich auf "Vergleiche Anbieter" klicke
    Dann sollte ich auf der "Warenkorbvergleichsseite" sein
    Und es wird <Inhalt> angezeigt
    Und als Resultat wird <Resultat> angezeigt


 Beispiele:
    | Artikel1									| Artikel2										| Provider1	| Provider2	| Artikel1Provider1	| Artikel1Provider2	| Artikel2Provider1	| Artikel2Provider2	| Inhalt				| Resultat	|
    | "Per Anhalter durch die Galaxis"	| "Der Herr der Ringe: Die Gefährten"	| ebay.de	| buch.de	| 12						| 15 						| 16						| 10						| "der Vergleich"	| buch.de	|
    | "Per Anhalter durch die Galaxis"	| "Der Herr der Ringe: Die Gefährten"	| ebay.de	| buch.de	| 9						| 12 						| 11						| 13						| "der Vergleich"	| ebay.de	|

