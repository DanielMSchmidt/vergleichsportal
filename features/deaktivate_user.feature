# language: de
Funktionalität: Nutzer sperren
  Der Administrator sperrt einen Nutzer

  Szenariogrundriss: Ein Nutzer wird gesperrt
    Angenommen es gibt den Nutzer mit der E-Mailadresse <Mail> und dem Passwort <Passwort> mit dem Administratorstatus "true".
    Und dieser ist angemeldet und ich bin auf der "Adminübersicht".
    Und es gibt den Nutzer2 mit der E-Mailadresse <Mail2> und dem Passwort <Passwort2> mit dem Administratorstatus <Admin2>
    Und das Sperrflag <Gesperrt2>
    Wenn der Nutzer auf den Button Sperren des Nutzer2 klickt
    Dann sollte dieser gesperrt sein.
    Und der Nutzer2 sollte das Sperrflag "true" haben
    Und der Button "Sperren" darf nicht sichtbar sein.

  Beispiele:
    | Mail             | Passwort         | Admin   | Gesperrt | Mail2           | Passwort2        | Admin2 | Gesperrt2 |
    | "admin@web.de"   | "adminpasswort"  | true    | false    | "nutzer@web.de" | "nutzerpasswort" | false  | flase     |