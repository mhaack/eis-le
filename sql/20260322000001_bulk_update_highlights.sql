/* Bulk update highlights for all shops from editorial review */

/* 1. San Remo */
UPDATE shops SET highlights = '[{"icon": "map-pin", "title": "Stadtbummel-Klassiker", "text": "Direkt in der Fußgängerzone an der Nikolaikirche – ideal für den Stadtbummel"}, {"icon": "sun", "title": "Große Außenterrasse", "text": "Beliebte Straßenterrasse mit bester Sichtlage mitten in der Innenstadt"}, {"icon": "star", "title": "Zitroneneis & Gianduja", "text": "Besonders empfohlen: das frische Zitroneneis und die cremige Gianduja-Sorte"}]'::jsonb
WHERE id::text LIKE '02524fa6%';

/* 2. Softeisbar Leipzig — MERGE: keep existing Lieferservice + new */
UPDATE shops SET highlights = '[{"icon": "truck", "title": "Lieferservice", "text": "Softeislieferservice auf Bestellung"}, {"icon": "refresh-cw", "title": "Täglich wechselnde Sorten", "text": "Jeden Tag zwei neue Softeissorten – immer eine Überraschung"}, {"icon": "leaf", "title": "Sächsische Rohstoffe", "text": "Traditionell hergestellt mit regionalen Zutaten aus Sachsen"}, {"icon": "smile", "title": "Kinderfreundlich", "text": "Kinderstühle und Kreide zum Malen auf der Straße vorhanden"}]'::jsonb
WHERE id::text LIKE '0374b363%';

/* 3. Zum Pillendreher */
UPDATE shops SET highlights = '[{"icon": "heart", "title": "Echter Geheimtipp", "text": "Kaum touristisch, stark von Stammkunden frequentiert – ein echtes Nachbarschaftscafé"}, {"icon": "music", "title": "Kulturort im Viertel", "text": "Regelmäßige Lesungen und Stadtteilveranstaltungen in Stötteritz"}, {"icon": "sparkles", "title": "Handgemachtes Eis", "text": "Kreative und wechselnde Sorten mit selbstgemachten Pralinen"}, {"icon": "coffee", "title": "Ausgezeichneter Kaffee", "text": "Von Stammgästen für seinen besonders guten Kaffee gelobt"}]'::jsonb
WHERE id::text LIKE '06d4d73a%';

/* 4. TONIS icecream Thomaskirchhof — REPLACE */
UPDATE shops SET highlights = '[{"icon": "leaf", "title": "Zertifiziertes Bio-Eis", "text": "Prämiertes Bio-Eis ohne künstliche Zusatzstoffe – ''Kein Bullshit. Nur Icecream.''"}, {"icon": "sparkles", "title": "Vegan & glutenfrei", "text": "Komplett vegane und glutenfreie Optionen für alle Unverträglichkeiten"}, {"icon": "award", "title": "Legendäre Bio-Waffeln", "text": "Von Gästen als ''beste Waffeln der Stadt'' bezeichnet – ein Muss"}]'::jsonb
WHERE id::text LIKE '09efe119%';

/* 5. Eiscafé Oase */
UPDATE shops SET highlights = '[{"icon": "leaf", "title": "Echte Minze", "text": "Zitrone-Minze mit frischer echter Minze – kein Aromaeis"}, {"icon": "heart", "title": "Faire Preise", "text": "Selbstgemachtes Eis zu fairen Preisen – ohne Aufschlag für Qualität"}, {"icon": "smile", "title": "Familiäres Ambiente", "text": "Herzlicher, persönlicher Service in ruhiger Südlage"}]'::jsonb
WHERE id::text LIKE '0a5c0f8c%';

/* 6. Eiscafé / Restaurant „Mario Gelato" */
UPDATE shops SET highlights = '[{"icon": "sparkles", "title": "Riesige Eisauswahl", "text": "Spaghettieis-Becher allein auf zwei Seiten – eine der größten Eismenüs der Stadt"}, {"icon": "thumbs-up", "title": "Viele Kombinationen", "text": "Eis mit oder ohne Alkohol, mit oder ohne Früchten – individuell zusammenstellbar"}]'::jsonb
WHERE id::text LIKE '11ff8dbe%';

/* 7. Softeisbude */
UPDATE shops SET highlights = '[{"icon": "leaf", "title": "Veganes Softeis", "text": "Veganes Softeis ganzjährig verfügbar"}, {"icon": "map-pin", "title": "Am Karl-Heine-Kanal", "text": "Idealer Stopp für Spaziergänger entlang des Karl-Heine-Kanals"}, {"icon": "zap", "title": "To-go-Konzept", "text": "Unkompliziertes Mitnehmen – direkt vom Stand"}]'::jsonb
WHERE id::text LIKE '130968a1%';

/* 8. LuiLui Eisladen Anger-Crottendorf */
UPDATE shops SET highlights = '[{"icon": "award", "title": "4,9 Sterne", "text": "Einer der bestbewerteten Eisläden in ganz Leipzig"}, {"icon": "heart", "title": "100 % hausgemacht", "text": "Alle Sorten werden von Inhaberin Franziska persönlich hergestellt"}, {"icon": "sparkles", "title": "Kreative Sorten", "text": "Von Himbeer-Lavendel bis Gummibärchen – wechselnde Kreationen und vegane Optionen"}]'::jsonb
WHERE id::text LIKE '1dc29c72%';

/* 9. Eisdiele Brakers */
UPDATE shops SET highlights = '[{"icon": "heart", "title": "Nachbarschaftstreffpunkt", "text": "Seit Jahren beliebter Anlaufpunkt für das Connewitzer Viertel"}, {"icon": "snowflake", "title": "Klassisches Softeis", "text": "Traditionelles Softeis mit nostalgischem Flair"}]'::jsonb
WHERE id::text LIKE '20eeb516%';

/* 10. SÜSSKIND.EIS */
UPDATE shops SET highlights = '[{"icon": "award", "title": "''Bestes Eis in Leipzig''", "text": "Von vielen Einheimischen als das beste Eis der Stadt bezeichnet"}, {"icon": "leaf", "title": "Keine künstlichen Zusätze", "text": "Komplett ohne Aromen, Farbstoffe oder Zusatzstoffe – was draufsteht, ist drin"}, {"icon": "map-pin", "title": "Regionale Zutaten", "text": "Obst und Gemüse aus Gärten der direkten Umgebung"}, {"icon": "sparkles", "title": "Außergewöhnliche Sorten", "text": "Cranberry-Tonic, Birne-Lavendel, Kefir-Heidelbeere – keine Eisdiele ist kreativer"}]'::jsonb
WHERE id::text LIKE '21f58e4b%';

/* 11. CN EISCAFE & BISTRO */
UPDATE shops SET highlights = '[{"icon": "heart", "title": "Café & Bistro kombiniert", "text": "Eis, Mittagstisch, Hausmannskost und frischer Kuchen unter einem Dach"}, {"icon": "smile", "title": "Familiäre Atmosphäre", "text": "Sehr einladendes, familiäres Ambiente mit freundlichem Personal"}, {"icon": "leaf", "title": "Selbstgemachtes Eis", "text": "Hausgemachtes Eis und frischer Kuchen täglich"}]'::jsonb
WHERE id::text LIKE '23280edf%';

/* 12. TONIS icecream KÖ */
UPDATE shops SET highlights = '[{"icon": "sun", "title": "Grüner Freisitz", "text": "Wunderschöner begrünter Außenbereich auf der Könneritzstraße"}, {"icon": "leaf", "title": "Bio-zertifiziert", "text": "Prämiertes Bio-Eis ohne Aromen und Farbstoffe"}, {"icon": "sparkles", "title": "Kreative Sorten", "text": "Gurke-Tonic, Cookie Dough, Haselnuss – neben Bio-Klassikern"}]'::jsonb
WHERE id::text LIKE '28d2984a%';

/* 13. 034E1S */
UPDATE shops SET highlights = '[{"icon": "award", "title": "4,9 Sterne", "text": "Außergewöhnliche Bewertung – einer der bestbewerteten Eisläden der Stadt"}, {"icon": "leaf", "title": "Zero-Waste-freundlich", "text": "Eigenen Behälter mitbringen willkommen – nachhaltig gedacht"}, {"icon": "sparkles", "title": "Exotische Spezialitäten", "text": "Kulfi aus Pistazien, Safran und Kardamom als indische Besonderheit"}, {"icon": "refresh-cw", "title": "Täglich wechselnd", "text": "Jeden Tag neue Sorten – lohnt sich mehrfach zu besuchen"}]'::jsonb
WHERE id::text LIKE '2c70f8cf%';

/* 14. Gustav H. – Vanille und Zimt Eismanufaktur */
UPDATE shops SET highlights = '[{"icon": "sparkles", "title": "Außergewöhnliche Sorten", "text": "Heidelbeer-Lavendel, Zitrone-Meringue, Quark-Sanddorn – nie das Gewöhnliche"}, {"icon": "map-pin", "title": "Nah am Lene-Voigt-Park", "text": "Ruhige Lage in Reudnitz, nah am beliebten Naherholungsgebiet"}]'::jsonb
WHERE id::text LIKE '2d284bf3%';

/* 15. Mr. Borella */
UPDATE shops SET highlights = '[{"icon": "map-pin", "title": "Direkt am Augustusplatz", "text": "Beste Lage mit Blick auf den Augustusplatz und bunte Schirme auf den Treppenstufen"}, {"icon": "gift", "title": "Unlimitierte Toppings", "text": "Selfservice-Konzept: so viele Toppings wie man möchte für einen Fixpreis"}, {"icon": "camera", "title": "Instagram-tauglich", "text": "Bunte Schirme, Sitzkissen, Augustusplatz – perfekte Foto-Kulisse"}]'::jsonb
WHERE id::text LIKE '2e39985e%';

/* 16. Thommy's Eismanufaktur */
UPDATE shops SET highlights = '[{"icon": "sparkles", "title": "Außergewöhnliche Sorten", "text": "Schwarzer Sesam, Ananas-Curry, Marzipan – Sorten, die man sonst nirgends findet"}, {"icon": "heart", "title": "Selbstgebackene Waffeln", "text": "Alle Waffeln werden im Haus gebacken – frisch und knusprig"}, {"icon": "refresh-cw", "title": "Immer neue Sorten", "text": "Wechselndes Sortiment lädt zum Wiederkommen ein"}]'::jsonb
WHERE id::text LIKE '3ae7f90d%';

/* 17. Miltitzer Eiscafé */
UPDATE shops SET highlights = '[{"icon": "sparkles", "title": "Einzigartige Sorten", "text": "Rose und Crispy Orange – Sorten, die man in Leipzig nur hier findet"}, {"icon": "sun", "title": "Großer Außenbereich", "text": "Schöner und weitläufiger Außenbereich zum Verweilen"}, {"icon": "map-pin", "title": "Im Elsterauengebiet", "text": "Ruhige, naturnahe Lage im westlichen Leipzig direkt am Auengebiet"}, {"icon": "heart", "title": "Starke Stammkundschaft", "text": "Beliebteste Eisdiele im Westen Leipzigs bei Einheimischen"}]'::jsonb
WHERE id::text LIKE '3b182b07%';

/* 18. Eis Café Tiziano */
UPDATE shops SET highlights = '[{"icon": "clock", "title": "Lange Öffnungszeiten", "text": "Täglich bis 20 Uhr geöffnet – Eis auch am späten Nachmittag"}, {"icon": "thumbs-up", "title": "Über 2.000 Bewertungen", "text": "Stark frequentiert und gut etabliert im Paunsdorfer Umfeld"}, {"icon": "heart", "title": "Klassisches Eiscafé", "text": "Breites Angebot in traditioneller Eiscafé-Atmosphäre mit Sitzplätzen"}]'::jsonb
WHERE id::text LIKE '3e937df1%';

/* 19. Shady punkt Leipzig */
UPDATE shops SET highlights = '[{"icon": "sparkles", "title": "Mix-in-Konzept", "text": "Eis wird individuell zusammengestellt und mit Toppings versehen – wie ein persönlicher Eisbecher"}, {"icon": "zap", "title": "Ungewöhnliche Kombinationen", "text": "Sorten wie Ayran & Mango oder Ayran & Granatapfel – mutig und einzigartig"}, {"icon": "sun", "title": "Ruhiger Außenbereich", "text": "Sitzplätze abseits der Straßenbahn und des Verkehrslärms"}]'::jsonb
WHERE id::text LIKE '479e2fe3%';

/* 20. Eiscafè Eis-Zapfen */
UPDATE shops SET highlights = '[{"icon": "sparkles", "title": "Ungewöhnliche Sorten", "text": "Duplo, Bacardi, Brezel, Pistazie – Sorten abseits des Mainstreams"}, {"icon": "heart", "title": "Gemütliche Eisdiele", "text": "Kleines Café mit persönlichem Charakter und kreativer Auswahl"}]'::jsonb
WHERE id::text LIKE '47dd96f0%';

/* 21. Eiscafé Prinz */
UPDATE shops SET highlights = '[{"icon": "map-pin", "title": "Neben dem Clara-Zetkin-Park", "text": "Perfekte Lage für eine Pause beim Spaziergang durch den Park"}, {"icon": "refresh-cw", "title": "Täglich neue Sorten", "text": "Wechselnde Softeis-Sorten – lohnt sich regelmäßig vorbeizuschauen"}, {"icon": "smile", "title": "Humorvoller Inhaber", "text": "Der freundliche und witzige Inhaber ist Teil des Erlebnisses"}]'::jsonb
WHERE id::text LIKE '4c7814b2%';

/* 22. Eiscafé Florenz Leipzig */
UPDATE shops SET highlights = '[{"icon": "award", "title": "Seit 1946", "text": "Eines der ältesten Eiscafés in Leipzig – Tradition seit fast 80 Jahren"}, {"icon": "sun", "title": "Schattiger Innenhof", "text": "Wunderschöner, ruhiger Freisitz im Innenhof – Erholung vom Straßenlärm"}, {"icon": "sparkles", "title": "Mozartkugel-Eis", "text": "Die Signature-Sorte des Hauses – ein Muss für Erstbesucher"}, {"icon": "heart", "title": "Windbeutel-Spezialität", "text": "Windbeutel mit Eis und frischen Erdbeeren – von Stammgästen heiß geliebt"}]'::jsonb
WHERE id::text LIKE '52679e6c%';

/* 23. Eismanufaktur Borkmann */
UPDATE shops SET highlights = '[{"icon": "clock", "title": "24/7 Eisautomat", "text": "Eisautomat vor dem Laden – Eis zu jeder Tages- und Nachtzeit"}, {"icon": "leaf", "title": "Saisonal & handgemacht", "text": "Handgemacht mit saisonalen Zutaten und nachhaltigem Anspruch"}, {"icon": "sparkles", "title": "Rhabarber-Hafervanille", "text": "Ungewöhnliche Signature-Sorte – Rhabarber trifft auf Hafer und Vanille"}]'::jsonb
WHERE id::text LIKE '531bb07e%';

/* 24. Il buon Gelato — REPLACE (dog icon now supported) */
UPDATE shops SET highlights = '[{"icon": "sparkles", "title": "Ausgefallene Sorten", "text": "Lakritze, Zuckerwatte, Pokemon – neben klassischem Pistazie und Co."}, {"icon": "dog", "title": "Hundeeis", "text": "Spezielle Hundeeis-Sorten für Vierbeiner"}, {"icon": "map-pin", "title": "Karl-Heine-Straße Plagwitz", "text": "Gute Lage in einem der lebendigsten Viertel Leipzigs"}]'::jsonb
WHERE id::text LIKE '5bd3e067%';

/* 25. Café Eisträumerei */
UPDATE shops SET highlights = '[{"icon": "heart", "title": "Hauseigene Eiswerkstatt", "text": "Alle Sorten werden vor Ort in der eigenen Werkstatt produziert"}, {"icon": "sparkles", "title": "Exotische Sorten", "text": "Schwarzbier, Kürbis, Knusperflocken – immer wieder überraschend neu"}, {"icon": "leaf", "title": "Vegan & laktosefrei", "text": "Vegane und laktosefreie Optionen ganzjährig verfügbar"}, {"icon": "coffee", "title": "Hausgemachte Kuchen", "text": "Frische Kuchen als perfekte Ergänzung zum Eis"}]'::jsonb
WHERE id::text LIKE '5c5c57ac%';

/* 26. Softi to go */
UPDATE shops SET highlights = '[{"icon": "map-pin", "title": "Einzige Option im Kiez", "text": "Eine der wenigen Eisdielen im östlichen Neuschönefeld"}, {"icon": "smile", "title": "Faire Preise", "text": "Softeis zu ehrlichen Preisen ohne Aufschlag"}]'::jsonb
WHERE id::text LIKE '60d2bd86%';

/* 27. Kännchenklein */
UPDATE shops SET highlights = '[{"icon": "gift", "title": "Selfservice-Toppings", "text": "Saucen und Streusel selbst dosieren – volle Kontrolle über den eigenen Eisbecher"}, {"icon": "heart", "title": "Gemütliche Café-Atmosphäre", "text": "Kleines, einladendes Café mitten im Zentrum"}, {"icon": "sparkles", "title": "Hochwertiges Softeis", "text": "Cremiges Softeis aus hochwertigen Zutaten"}]'::jsonb
WHERE id::text LIKE '66921bbc%';

/* 28. Gusto Italiano Eiscafé */
UPDATE shops SET highlights = '[{"icon": "heart", "title": "Traditionell-italienisch", "text": "Klassisches Eiscafé-Konzept nach bewährter italienischer Tradition"}]'::jsonb
WHERE id::text LIKE '6cd593e6%';

/* 29. BECHER.ODER.WAFFEL — MERGE: keep Hundeeis (dog icon) + new */
UPDATE shops SET highlights = '[{"icon": "camera", "title": "Dekorierte Eisbecher", "text": "Wunderschön gestaltete Eisbecher – handwerklich und visuell beeindruckend"}, {"icon": "sparkles", "title": "Handgemachtes Eis", "text": "Selbstproduziertes Eis in klassischen und kreativen Sorten"}, {"icon": "dog", "title": "Hundeeis", "text": "Eis speziell für Hunde"}]'::jsonb
WHERE id::text LIKE '6e55bd4a%';

/* 30. Streit's Gelato — MERGE: keep Hundeeis (dog icon) + new */
UPDATE shops SET highlights = '[{"icon": "award", "title": "4,9 Sterne", "text": "Außergewöhnliche Bewertung – einer der besten Eisläden im Südwesten"}, {"icon": "sparkles", "title": "Rolleis-Spezialität", "text": "Aufwendig gefertigtes Rolleis (Roll Ice Cream) als Besonderheit"}, {"icon": "leaf", "title": "Bio & vegan", "text": "Komplett vegane und bio-zertifizierte Optionen"}, {"icon": "dog", "title": "Hundeeis", "text": "Eis speziell für Hunde"}]'::jsonb
WHERE id::text LIKE '6ea22c6e%';

/* 31. Eiscafé Eisflöckchen */
UPDATE shops SET highlights = '[{"icon": "heart", "title": "Waffeln & Kräppelchen", "text": "Selbstgemachte Waffeln und Kräppelchen als besondere Spezialität"}, {"icon": "smile", "title": "Familiäre Atmosphäre", "text": "Entspanntes Eiscafé mit familiärem Charakter im Süden der Stadt"}]'::jsonb
WHERE id::text LIKE '73e75bb7%';

/* 32. Anna's Eisschleckerei */
UPDATE shops SET highlights = '[{"icon": "award", "title": "5,0 Sterne", "text": "Perfekte Bewertung – außergewöhnliche Qualität in Markkleeberg"}, {"icon": "sparkles", "title": "Geheimtipp südlich von Leipzig", "text": "Kaum bekannt, aber mit unschlagbarer Qualität"}]'::jsonb
WHERE id::text LIKE '7a272060%';

/* 33. LuiLui Eisladen Lindenau */
UPDATE shops SET highlights = '[{"icon": "gift", "title": "Waffeln mit Schnickschnack", "text": "Hausgemachte Waffeln mit frei wählbaren Toppings"}, {"icon": "leaf", "title": "Vegane Sorten", "text": "Vegane Optionen ganzjährig im Angebot"}]'::jsonb
WHERE id::text LIKE '7a451585%';

/* 34. Crêpeland */
UPDATE shops SET highlights = '[{"icon": "award", "title": "4,9 Sterne", "text": "Eine der bestbewerteten Adressen in ganz Leipzig"}, {"icon": "sparkles", "title": "Frische Crêpes", "text": "Großzügig portionierte, frisch gemachte Crêpes als Kernprodukt"}]'::jsonb
WHERE id::text LIKE '7ee0c1ba%';

/* 35. La Luna */
UPDATE shops SET highlights = '[{"icon": "clock", "title": "Lange Öffnungszeiten", "text": "Täglich bis 20 Uhr geöffnet"}, {"icon": "heart", "title": "Klassisches Eiscafé", "text": "Bewährtes Angebot mit breiter Auswahl an Eissorten"}]'::jsonb
WHERE id::text LIKE '7ee17125%';

/* 36. JJ Softeis */
UPDATE shops SET highlights = '[{"icon": "sparkles", "title": "Vielfältige Softeis-Becher", "text": "Große Auswahl an Softeis-Kreationen und Bechervariationen"}, {"icon": "smile", "title": "Sehr freundliches Team", "text": "Von Gästen immer wieder für den aufmerksamen und freundlichen Service gelobt"}]'::jsonb
WHERE id::text LIKE '85803131%';

/* 37. Eiscafé Sabine */
UPDATE shops SET highlights = '[{"icon": "coffee", "title": "Kuchen & Torten", "text": "Breite Auswahl an Torten und hausgemachten Kuchen neben dem Eis"}, {"icon": "clock", "title": "Früh geöffnet", "text": "Sonntags ab 7 Uhr – Eis schon zum Frühstück möglich"}]'::jsonb
WHERE id::text LIKE '8f2153b2%';

/* 38. Mein Eis Leipzig — REPLACE */
UPDATE shops SET highlights = '[{"icon": "map-pin", "title": "Nah am Zoologischen Garten", "text": "Nur ca. 300 m vom Leipziger Zoo – ideal nach dem Tierpark-Besuch"}, {"icon": "sparkles", "title": "Kulfi-Spezialität", "text": "Indisches Kulfi aus Pistazie, Safran und Kardamom – einzigartig in Leipzig"}, {"icon": "refresh-cw", "title": "Saisonale Sorten", "text": "Wechselnde saisonale Kreationen mit natürlichen Zutaten"}, {"icon": "leaf", "title": "Natürliche Zutaten", "text": "Vegane Optionen vorhanden, keine künstlichen Zusatzstoffe"}]'::jsonb
WHERE id::text LIKE '9049bdf9%';

/* 39. FREDO eis, hot dogs & co. */
UPDATE shops SET highlights = '[{"icon": "award", "title": "4,9 Sterne", "text": "Außergewöhnliches Qualitätsniveau – beinahe perfekte Bewertung"}, {"icon": "leaf", "title": "Komplett vegan", "text": "Veganes Sortiment von Softeis über Hot Dogs bis zu Waffeln"}, {"icon": "zap", "title": "Mehr als Eis", "text": "Hot Dogs, Waffeln und Glühwein im Winter – ganzjährig attraktiv"}]'::jsonb
WHERE id::text LIKE '94699345%';

/* 40. Eisautomat Holzhausen */
UPDATE shops SET highlights = '[{"icon": "clock", "title": "24/7 geöffnet", "text": "Der Eisautomat läuft rund um die Uhr – Eis zu jeder Zeit"}, {"icon": "leaf", "title": "Nachhaltige Produktion", "text": "Milch von Weidekühen – bewusst und nachhaltig hergestellt"}, {"icon": "map-pin", "title": "Einziger Automat im Osten", "text": "Einziger Eisautomat im Bereich Holzhausen / Südost"}]'::jsonb
WHERE id::text LIKE '95aa9eb3%';

/* 41. Eisbrennerei — REPLACE */
UPDATE shops SET highlights = '[{"icon": "zap", "title": "Kugelcocktail-Eis", "text": "Einziger Laden in Leipzig mit alkoholischen Eissorten wie White Russian oder Gin-Basilikum"}, {"icon": "refresh-cw", "title": "Täglich 8 neue Sorten", "text": "Täglich wechselndes alkoholisches Sortiment – immer eine Überraschung"}, {"icon": "leaf", "title": "Ohne Aromen & Farbstoffe", "text": "Alle Sorten hausgemacht – keine Kunstzusätze, vegane Optionen inklusive"}, {"icon": "coffee", "title": "Brownies & Waffeln", "text": "Hausgemachte Brownies und Waffeln als süße Begleitung"}]'::jsonb
WHERE id::text LIKE 'a12b4cb2%';

/* 42. Eiscafé La Luna – Paunsdorf Center */
UPDATE shops SET highlights = '[{"icon": "clock", "title": "Lange Öffnungszeiten", "text": "Mo–Sa täglich bis 20 Uhr – Eis nach dem Shoppen"}, {"icon": "heart", "title": "Klassisches Eiscafé", "text": "Traditionelles Café-Ambiente mit breitem Angebot"}]'::jsonb
WHERE id::text LIKE 'aa9cb036%';

/* 43. Softeisbar Chemnitzer Straße */
UPDATE shops SET highlights = '[{"icon": "snowflake", "title": "DDR-Traditionssofteis", "text": "Softeis nach traditioneller DDR-Art aus sächsischen Zutaten"}, {"icon": "refresh-cw", "title": "Täglich neue Sorten", "text": "Wechselnde Geschmacksrichtungen jeden Tag"}]'::jsonb
WHERE id::text LIKE 'b3e806f2%';

/* 44. Vanille & Zimt Eismanufaktur — REPLACE */
UPDATE shops SET highlights = '[{"icon": "leaf", "title": "Echte Zutaten", "text": "Man schmeckt, was drin ist – kein Kunstgeschmack, nur echte Aromen"}, {"icon": "sparkles", "title": "Handgemachte Kreationen", "text": "Kreative Sorten wie Heidelbeer-Lavendel oder Quark-Sanddorn"}]'::jsonb
WHERE id::text LIKE 'b3f893ef%';

/* 45. Sodann's Softeis Wiederitzsch */
UPDATE shops SET highlights = '[{"icon": "gift", "title": "Take-home-Softeis", "text": "Tiefkühlsorten zum Mitnehmen nach Hause – Eisgenuss auch zuhause"}]'::jsonb
WHERE id::text LIKE 'b49e951a%';

/* 46. Softeis Eugen Hendrich */
UPDATE shops SET highlights = '[{"icon": "award", "title": "''Bestes Softeis in Leipzig''", "text": "Von zahlreichen Stammgästen als das cremigste Softeis der Stadt bezeichnet"}, {"icon": "refresh-cw", "title": "Täglich wechselnde Sorten", "text": "Jeden Tag eine neue Geschmacksrichtung – lohnt sich regelmäßig"}]'::jsonb
WHERE id::text LIKE 'bb53760b%';

/* 47. Softeis Lindenthaler Straße */
UPDATE shops SET highlights = '[{"icon": "snowflake", "title": "Puristisches Softeis", "text": "Klares Konzept: cremiges Softeis ohne Ablenkung"}, {"icon": "refresh-cw", "title": "Täglich neue Sorten", "text": "Wechselnde Geschmacksrichtungen im Gohlis-Kiez"}]'::jsonb
WHERE id::text LIKE 'c57e72c7%';

/* 48. Dolce Freddo Eismanufaktur */
UPDATE shops SET highlights = '[{"icon": "zap", "title": "Außergewöhnlich schneller Service", "text": "Trotz hoher Auslastung sehr zügige und freundliche Bedienung"}, {"icon": "sparkles", "title": "Dekorierte Eisbecher", "text": "Perfekt gestaltete Eisbecher – liebevoll und stilvoll präsentiert"}, {"icon": "clock", "title": "Lange Öffnungszeiten", "text": "Täglich bis 20 Uhr – Eis auch abends nach dem Zug"}]'::jsonb
WHERE id::text LIKE 'caf77a60%';

/* 49. Eis Oase */
UPDATE shops SET highlights = '[{"icon": "smile", "title": "Kinder zum halben Preis", "text": "Kinder-Eiskugeln zum halben Preis – familienfreundlich und fair"}, {"icon": "heart", "title": "Freundlicher Service", "text": "Unkomplizierter, persönlicher Service im Nachbarschaftsstil"}]'::jsonb
WHERE id::text LIKE 'cba59bdc%';

/* 50. Milchbar Pinguin */
UPDATE shops SET highlights = '[{"icon": "award", "title": "Über 5.200 Bewertungen", "text": "Das meistbewertete Eiscafé in Leipzig – eine echte Stadtlegende"}, {"icon": "sun", "title": "Riesige Innenstadtterrasse", "text": "Große Terrasse im Herzen der Stadt – perfekt für laue Sommerabende"}, {"icon": "clock", "title": "Bis 22 Uhr geöffnet", "text": "Eines der wenigen Eiscafés, die auch spät abends noch offen sind"}, {"icon": "coffee", "title": "Komplettangebot", "text": "Frühstück, Mittagessen, Kuchen, Eis und Cocktails – alles unter einem Dach"}]'::jsonb
WHERE id::text LIKE 'db823e46%';

/* 51. Eisdiele am See — MERGE: keep Hundeeis (dog icon) + new */
UPDATE shops SET highlights = '[{"icon": "sparkles", "title": "Kreative Sorten", "text": "Schokolade-Chili und Schoko-Marzipan – außergewöhnliche Geschmackspaare"}, {"icon": "heart", "title": "Handgemacht", "text": "Eis in Eigenproduktion mit kreativen saisonalen Kreationen"}, {"icon": "dog", "title": "Hundeeis", "text": "Eis speziell für Hunde"}]'::jsonb
WHERE id::text LIKE 'e5145fdb%';

/* 52. Mamalicious */
UPDATE shops SET highlights = '[{"icon": "zap", "title": "Eis & Döner", "text": "Kombination aus Eisbar und Döner-Restaurant – Süßes und Herzhaftes"}, {"icon": "thumbs-up", "title": "Große Portionen", "text": "Großzügige Portionen zu fairen Preisen"}]'::jsonb
WHERE id::text LIKE 'f2a521f6%';

/* 53. likken */
UPDATE shops SET highlights = '[{"icon": "sparkles", "title": "Schwarze Pflanzenkohle-Waffel", "text": "Das Markenzeichen von likken – pechschwarze Waffel aus Pflanzenkohle, ganzjährig"}, {"icon": "refresh-cw", "title": "9 täglich wechselnde Sorten", "text": "Jeden Tag neue Kreationen – von Omas Teigschüssel bis Schwarze Kokosnuss"}, {"icon": "leaf", "title": "Vegan & saisonal", "text": "Alle Fruchtsorten vegan, Softeis ganzjährig, natürliche Zutaten"}]'::jsonb
WHERE id::text LIKE 'f3c5087a%';

/* 54. Eisdiele Pfeifer */
UPDATE shops SET highlights = '[{"icon": "heart", "title": "Familiäres Flair", "text": "Kein Touristenlokal – ein echtes Viertelcafé mit persönlichem Charakter"}, {"icon": "sparkles", "title": "Handgemachtes Eis", "text": "Traditionell hergestelltes Eis nach bewährten Rezepten"}, {"icon": "star", "title": "Südvorstadt-Institution", "text": "Seit Jahren fester Bestandteil des Lebens im Karli-Viertel"}]'::jsonb
WHERE id::text LIKE 'f68ed2d0%';

/* 55. Erikas Eiscafé Eutritzsch — REPLACE */
UPDATE shops SET highlights = '[{"icon": "award", "title": "Eis von SÜSSKIND.EIS", "text": "Das Eis kommt direkt von Manja – Inhaberin des legendären SÜSSKIND.EIS in Lützschena"}, {"icon": "sparkles", "title": "Bubble-Waffeln", "text": "Instagrammable Bubble-Waffeln als Instagram-Highlight und Geschmackserlebnis"}, {"icon": "coffee", "title": "Mehr als Eis", "text": "Selbstgemachte Limonaden, Milchshakes und Wochenend-Frühstück"}, {"icon": "gift", "title": "Büchertauschregal", "text": "Bücher tauschen beim Eisessen – Café mit Seele und Gemeinschaftsgefühl"}]'::jsonb
WHERE id::text LIKE 'f9cc49b2%';
