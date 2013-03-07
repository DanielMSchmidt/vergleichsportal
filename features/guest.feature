# language: de
Funktionalität: Artikel zu Warenkorb hinzufügen / entfernen
  Der Gast oder Nutzer kann Artikel zu seinem Warenkorb hinzufügen

  Szenariogrundriss: Artikel zum Warenkorb hinzufügen für eingeloggte User
    Angenommen es gibt den Nutzer mit der E-Mailadresse <Mail> und dem Passwort <Passwort> mit dem Adminstatus <Admin>
    Und der Nutzer ist eingeloggt
    Und ich bin auf der "Startseite"
    Und ich suche nach <Suche>
    Und mein Warenkorb ist leer
    Wenn Ergebnisse für die Suche existieren
    Und ich den ersten Artikel hinzufüge
    Dann sollte es einen Artikel in meinem aktuellen Warenkorb geben

  Szenariogrundriss: Artikel vom Warenkorb entfernen für eingeloggte User
    Angenommen es gibt den Nutzer mit der E-Mailadresse <Mail> und dem Passwort <Passwort> mit dem Adminstatus <Admin>
    Und der Nutzer ist eingeloggt
    Und ich bin auf der "Startseite"
    Und mein Warenkorb hat ein Element
    Wenn ich auf Warenkorb klicke
    Und ich auf Artikel entfernen klicke
    Dann sollte der aktuelle Warenkorb leer sein

  Szenariogrundriss: Artikel zum Warenkorb hinzufügen für Gäste
    Angenommen ich bin auf der "Startseite"
    Und ich suche nach <Suche>
    Und mein Warenkorb ist leer
    Wenn Ergebnisse für die Suche existieren
    Und ich den ersten Artikel hinzufüge
    Dann sollte es einen Artikel in meinem aktuellen Warenkorb geben

  Szenariogrundriss: Artikel vom Warenkorb entfernen für Gäste
    Angenommen ich bin auf der "Startseite"
    Und ich suche nach <Suche>
    Und mein Warenkorb hat ein Element
    Wenn ich auf Warenkorb klicke
    Und ich auf Artikel entfernen klicke
    Dann sollte der aktuelle Warenkorb leer sein


  Beispiele:
  | Mail              | Passwort           | Admin   | Seite         | Suche                            |
  | "nutzer@web.de"   | "nutzerpasswort"   | false   | "Startseite"  | "Per Anhalter durch die Galaxis" |
  | "nutzer2@web.de"  | "nutzer2passwort"  | false   | "Startseite"  | "Seifenspender"                  |

 Szenariogrundriss: Warenkörbe wechseln
    Angenommen es gibt einen Warenkorb <Warenkorb1> und einen Warenkorb <Warenkorb2>
    Und mein aktiver Warenkorb ist <Warenkorb2>
    Und ich bin auf der "Warenkorbübersicht"
    Und ich hab den Warenkorb <Warenkorb1> ausgewählt
    Wenn ich auf "Auswählen" klicke
    Dann sollte ich auf der "Warenkorbansicht" sein
    Und mein aktiver Warenkorb ist <Warenkorb1>
