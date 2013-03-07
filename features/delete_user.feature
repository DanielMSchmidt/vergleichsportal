# language: de 
Funktionalität: Nutzer löschen
  Der Administrator löscht einen Nutzer

  Szenariogrundriss: Ein Nutzer wird gelöscht
    Angenommen es gibt den Nutzer mit der E-Mailadresse <Mail> und dem Passwort <Passwort> mit dem Administratorstatus "true".
    Und dieser ist angemeldet und ich bin auf der "Adminübersicht".
    Und es gibt den Nutzer2 mit der E-Mailadresse <Mail2> und dem Passwort <Passwort2> mit dem Administratorstatus <Admin2>
    Wenn der Nutzer auf den Button löschen des Nutzer2 klickt
    Dann sollte dieser sich nicht mehr im System befinden.

  Beispiele:
    | Mail             | Passwort         | Admin   | Gesperrt | Mail2           | Passwort2        | Admin2 | Gesperrt2 |
    | "admin@web.de"   | "adminpasswort"  | true    | false    | "nutzer@web.de" | "nutzerpasswort" | false  | flase     |