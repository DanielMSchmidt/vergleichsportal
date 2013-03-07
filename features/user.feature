# language: de
Funktionalität: Einloggen
  Der Gast loggt sich ein und wird zum Nutzer, bzw Admin

  Szenariogrundriss: Einloggen ohne Daten
    Angenommen es gibt den Nutzer mit der E-Mailadresse <Mail> und dem Passwort <Passwort> mit dem Adminstatus <Admin>
    Und ich bin auf der "Loginseite"
    Und ich klicke auf "Einloggen"
    Dann sollte ich nicht eingeloggt sein
    Und ich sollte auf der "Loginseite" sein
    Und es sollte ein Fehler bei E-Mail angezeigt werden

  Szenariogrundriss: Einloggen mit invalider E-Mail
    Angenommen es gibt den Nutzer mit der E-Mailadresse <Mail> und dem Passwort <Passwort> mit dem Adminstatus <Admin>
    Und ich bin auf der "Loginseite"
    Wenn ich gebe als Mailadresse "nicht_die_richtigen@daten.de" ein
    Und als Passwort <Passwort> ein
    Und ich klicke auf "Einloggen"
    Dann sollte ich nicht eingeloggt sein
    Und ich sollte auf der "Loginseite" sein
    Und es sollte ein Fehler bei E-Mail angezeigt werden

  Szenariogrundriss: Einloggen mit invalidem Passwort
    Angenommen es gibt den Nutzer mit der E-Mailadresse <Mail> und dem Passwort <Passwort> mit dem Adminstatus <Admin>
    Und ich bin auf der "Loginseite"
    Wenn ich gebe als E-Mailadresse <Mail> ein
    Und ich gebe als Passwort "not_my_password" ein
    Und ich klicke auf "Einloggen"
    Dann sollte ich nicht eingeloggt sein
    Und ich sollte auf der "Loginseite" sein
    Und es sollte ein Fehler bei Passwort angezeigt werden

  Szenariogrundriss: Einloggen mit validen Daten
    Angenommen es gibt den Nutzer mit der E-Mailadresse <Mail> und dem Passwort <Passwort> mit dem Adminstatus <Admin>
    Und ich bin auf der "Login" Seite
    Wenn ich gebe als Mailadresse <Mail> und als Passwort <Passwort> ein
    Und ich klicke auf "Einloggen"
    Dann sollte ich eingeloggt sein
    Und ich sollte auf der <Seite> sein

  Beispiele:
    | Mail             | Passwort         | Admin   | Seite        |
    | "nutzer@web.de"  | "nutzerpasswort" | false   | "Startseite" |
    | "admin@web.de"   | "adminpasswort"  | true    | "Adminseite" |

  Szenariogrundriss: Registrieren mit invalider E-Mail
    Angenommen es gibt noch keinen Nutzer
    Und ich bin auf der "Registrierenseite"
    Wenn ich gebe als Mailadresse "nicht_die_richtigendaten.de" ein
    Und ich gebe als Passwort <Passwort> ein
    Und ich klicke auf "Registrieren"
    Dann sollte ich nicht eingeloggt sein
    Und ich sollte auf der "Hauptseite" sein
    Und es sollte ein Fehler bei E-Mail angezeigt werden

  Szenariogrundriss: Registrieren mit zu kurzem Passwort
    Angenommen es gibt noch keinen Nutzer
    Und ich bin auf der "Registrierenseite"
    Wenn ich gebe als Mailadresse <Mail> ein
    Und ich gebe als Passwort "a" ein
    Und ich klicke auf "Registrieren"
    Dann sollte ich nicht eingeloggt sein
    Und ich sollte auf der "Hauptseite" sein
    Und es sollte ein Fehler bei Passwort angezeigt werden

  Szenariogrundriss: Registrieren mit validen Daten
    Angenommen es gibt noch keinen Nutzer
    Und ich bin auf der "Registrierenseite"
    Wenn ich gebe als Mailadresse <Mail> ein
    Und ich gebe als Passwort <Passwort> ein
    Und ich klicke auf "Registrieren"
    Dann sollte ich nicht eingeloggt sein
    Und ich sollte auf der "Hauptseite" sein
    Und es sollte eine E-Mail an mich versandt worden sein

  Beispiele:
    | Mail             | Passwort         | Admin   | Seite        |
    | "nutzer@web.de"  | "nutzerpasswort" | false   | "Startseite" |
    | "admin@web.de"   | "adminpasswort"  | true    | "Adminseite" |

  Szenariogrundriss: Passwort vergessen
    Angenommen es gibt den Nutzer mit der E-Mailadresse <Mail> und dem Passwort <Passwort> mit dem Adminstatus <Admin>
    Und ich bin auf der "PasswortVergessenSeite"
    Wenn ich gebe als Mailadresse <Mail> ein
    Und ich klicke auf "Registrieren"
    Dann sollte ich nicht eingeloggt sein
    Und ich sollte auf der "Hauptseite" sein
    Und es sollte eine E-Mail versendet werden


  Beispiele:
    | Mail             | Passwort         | Admin   | Seite        |
    | "nutzer@web.de"  | "nutzerpasswort" | false   | "Startseite" |
    | "admin@web.de"   | "adminpasswort"  | true    | "Adminseite" |
