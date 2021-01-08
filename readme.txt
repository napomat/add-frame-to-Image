Doppelklick auf die "start.bat" Datei.

Es öffnet sich ein Dialogfeld in dem der Ordner mit den Bildern ausgewählt werden muss.
Die Bilder werden bearbeitet und in einem Unterordner "with_border" gespeichert. 
Nachdem alle Bilder umgewandelt wurden öffnet sich der Ordner in dem die Bilder mit Rahmen liegen.

Die Dicke des Rahmens müsst ihr selbst herrausfinden. Um das irgendwie auszurechnen bin ich jetzt zu faul.

Die Rahmendicke könnt ihr in der "logic.ps1" Datei anpassen. 

Die verschiedenen Optionen für die Seitenverhältnisse können einzeln geändert werden.
Aktuell gibt es diese vier Stück zur Auswahl.
Beim aufrufen der Start.Bat wird nach dem Seitenverhältniss gefragt, danach wird der Ordner mit den Bildern gewählt.


################Variables################
$Bordercolor = "#eae4dd"


switch ( $aspectratioselect ){
  0 { # 7x5,5
    $BordersizeA = "97x77.6"
    $BordersizeB = "77.6x97"
    $aspectratioA = "1:0.78"
    $aspectratioB = "0.78:1"  }
  1 { #7x9,5
    $BordersizeA = "97x71,78"
    $BordersizeB = "71,78x97"
    $aspectratioA = "1:0,74"
    $aspectratioB = "0,74:1"  }
  2 { # 7x7
    $BordersizeA = "97x97"
    $BordersizeB = "97x97"
    $aspectratioA = "1:1"
    $aspectratioB = "1:1"  }
  3 { # 9,5x14,5
    $BordersizeA = "97x63.05"
    $BordersizeB = "63.05x97"
    $aspectratioA = "0.65:1"
    $aspectratioB = "1:0.65" }
}


