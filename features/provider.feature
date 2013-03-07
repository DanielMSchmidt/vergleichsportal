# language: de
Funktionalität: Provider deaktivieren
  Der Administrator deaktiviert einen Provider

  Szenariogrundriss: Der Administrator deaktiviert einen Provider
    Angenommen es gibt den Nutzer mit der E-Mailadresse "admin@localhost.lan" und dem Passwort "adminpasswort" mit dem Administratorstatus true
    Und dieser ist angemeldet und ist auf der "Adminübersicht"
    Und es gibt einen Provider mit dem Status true
    Wenn der Nutzer den Button deaktivieren drückt,
    Dann sollte sich der Status des Providers auf false ändern
    Und der Provider sollte den Status true haben
    Und der Button zum Aktivieren darf nicht sichtbar sein
    Und stattdessen der deaktivieren-Button angeboten werden


  Szenariogrundriss: Der Administrator aktiviert einen Provider
    Angenommen es gibt den Nutzer mit der E-Mailadresse "admin@localhost.lan" und dem Passwort "adminpasswort" mit dem Administratorstatus true
    Und dieser ist angemeldet und ist auf der "Adminübersicht"
    Und es gibt einen Provider mit dem Status false
    Wenn der Nutzer den Button deaktivieren drückt,
    Dann sollte sich der Status des Providers auf true ändern
    Und der Provider sollte den Status true haben
    Und der Button zum Deaktivieren darf nicht sichtbar sein
    Und stattdessen der aktivieren-Button angeboten werden