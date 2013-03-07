# language: de
Funktionalität: Werbung aktivieren
  Der Admin aktiviert eine Werbung

  Szenariogrundriss: Werbung aktivieren mit nur einer Werbung
    Angenommen es gibt den Administrator und eine Werbung
    Und ich bin auf der "Adminseite"
    Dann ist die Werbung schon aktiv

  Szenariogrundriss: Werbung aktivieren mit mehr als einer Werbung
    Angenommen es gibt den Administrator und eine aktive Werbung <aktiveWerbung> und weitere Werbungen
    Und ich bin auf der "Adminseite"
    Und ich klicke auf den Banner einer Werbung <neuAktiveWerbung> mit Status  <neuStatus>
    Dann sollte ich auf der "Adminseite" sein
    Und die Werbung <neuAktiveWerbung> hat den Status aktiv <neuStatusNeu>
    Und die Werbung <aktiveWerbung> hat den Status <StatusNeu>

Beispiele:
| aktiveWerbung | neuAktiveWerbung | neuStatus | neuStatusNeu | StatusNeu |
| "Werbung1"    | "Werbung2"	   | "inaktiv" | "aktiv"      | "inaktiv"   |
| "Werbung1"    | "Werbung1"	   | "aktiv"   | "aktiv"      | "aktiv"     |