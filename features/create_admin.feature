# language: de 
Funktionalität: Administrator erstellen
  Der Administrator erstellt einen weiteren Administrator

  Szenariogrundriss: Ein Nutzer wird mit Administratorrechten versehen.
    Angenommen es gibt den Nutzer mit der E-Mailadresse <Mail> und dem Passwort <Passwort> mit dem Administratorstatus "true".
    Und dieser ist angemeldet und ist auf der "Adminübersicht".
    Und es gibt den Nutzer2 mit der E-Mailadresse <Mail2> und dem Passwort <Passwort2> mit dem Administratorstatus <Admin2>
    Wenn der Nutzer auf den Button "zum Admin machen" des Nutzer2 klickt
    Dann sollte dieser den Administratorstatus "true" bekommen.
    Und der Nutzer2 den Administratorstatus "true" haben
    Und der Button "zum Admin machen" darf nicht sichtbar sein.

  Beispiele:
    | Mail             | Passwort         | Admin   | Gesperrt | Mail2          | Passwort2        | Admin2 | Gesperrt2 |
    | "admin@web.de"   | "adminpasswort"  | true    | false    | "nutzer@web.de" | "nutzerpasswort" | false  | false    |