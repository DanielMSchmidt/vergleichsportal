# language: de
Funktionalität: Werbung löschen
  Der Admin löscht die Daten einer Werbung

  Szenariogrundriss: Werbung löschen mit nur einer Werbung
    Angenommen es gibt den Administrator
    Und ich bin auf der "Adminseite"
    Dann kann ich die Werbung nicht löschen

  Szenariogrundriss: Werbung löschen mit mehr als einer Werbung
    Angenommen es gibt den Administrator und es gibt mehr als eine Werbung
    Und ich bin auf der "Adminseite"
    Und die Werbung die gelöscht werden soll hat den Status <Status>
    Und ich klicke auf "Löschen"
    Dann sollte ich auf der "Adminseite" sein
    Und die Werbung wurde gelöscht <geloescht>

  Beispiele:
  | Status        | geloescht |
  | "deaktiviert" | true      |
  | "aktiv"       | false     |
