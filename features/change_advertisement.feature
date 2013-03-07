# language: de
Funktionalität: Werbung ändern
  Der Admin ändert die Daten einer Werbung

  Szenariogrundriss: Werbung ändern
    Angenommen es gibt den Administrator und es gibt mindestens eine Werbung mit Bild-URL <BannerURL> und Link-URL <LinkURL>
    Und ich bin auf der "Adminseite"
    Und ich trage die neue Bild-URL <BildURL_NEU> und die neue Link-URL <LinkURL_NEU> in die Maske ein
    Und ich klicke auf "Speichern"
    Dann sollte ich auf der "Adminseite" sein
    Und die geänderte Werbung sollte die Bild-URL <BildURL_NEU> und die Link-URL <LinkURL_NEU> haben

   Beispiele:
   | Bild-URL                    | Link-URL                  | Bild-URL_NEU                   | Link-URL_NEU                 |
   | "http://www.bilder.de/url"  | "http://www.link.de/url"  | "http://www.bilder.de/neueurl" | "http://www.link.de/url"     |
   | "http://www.bilder.de/url"  | "http://www.link.de/url"  | ""                             | "http://www.link.de/neueurl" |
   | ""                          | "http://www.link.de/url"  | "http://www.bilder.de/url"     | ""                           |

