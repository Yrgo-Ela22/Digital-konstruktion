# Förebyggand av mestastabilitet via D-vippor
Förebyggande av metastabilitet* via double flop metoden, dvs. samtliga insignaler synkroniseras via två vippor. Kretsen som konstruerades föregående lektion har i utökats med metastabilitetsskydd. Implementering med D-vippor, både för hand i CircuitVerse samt i VHDL.

Reset-signal synkroniseras via två D-vippor, där synkroniseras reset-signal reset_s2_n används i resten av kretsen. Postfix s2 innebär att signalen
i fråga har synkroniserats med två vippor i enlighet med double flop metoden.

Tryckknappen button_n synkroniseras via två D-vippor och ytterligare en vippa används för flankdetektering, där button_s2_n utgör "nuvarande" insignal och
button_s3_n utgör "föregående" insignal. Vid nedtryckning (fallande flank) gäller att button_s2_n = 0 och button_s3_n = 1. Då ettställs signalen
button_pressed_s2 för att indikera knapptryckning. Vid nedtryckning av tryckknappen togglas en lysdiod.

Filen "falling_edge_detection_metastability_protection_added.qar" utgör konstruktionen från föregående lektion, utökad med metastabilitetsskydd.
Filen "falling_edge_detection_metastability_protection_added_rtl.png" demonstrerar motsvarande grindnät realiserat i CircuitVerse.

Bifogad katalog "event_detection_metastability" innehåller kretsschema samt hårdvarubeskrivande kod (syntesbar kod samt testbänk) både i VHDL och 
SystemVerilog för en generisk konstruktion, där 1 - 3 tryckknappar detekteras på fallande flank (nedtryckning) via D-vippor. 
Vid nedtryckning (föregående insignal är hög, nuvarande insignal är låg) togglas motsvarande lysdiod.

Filen "led_toggle_meta_prev_3_buttons.cv" demonstrerar kretsschemat för ett system, där tre lysdioder togglas vid nedtryckning av var sin tryckknapp
(eventdetektering på fallande flank), där metastabilitetsskydd används på samtliga insignaler. Denna fil kan öppnas i CircuitVerse.
Motsvarande grindnät visas i filen "led_toggle_meta_prev_3_buttons.png".

*Tillstånd där utsignalen ur en vippa varken är 0 eller 1, vilket kan uppstå när en insignal ändrar värde för nära en klockpuls. Då hinner signalen
inte stabilisera sig på 0 eller 1 och vippans utsignal kan då sväva någonstans mellan 0 - 1 en viss tid. Oftast stabiliserar sig sedan vippans utsignal
till 0 eller 1, annars kan systemfel uppstå, då vissa efterföljande grindar kan tolka vippans utsignal som 0, andra som 1, vilket kan få märkliga effekter.

