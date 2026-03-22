/* Bulk update specialty and location_description for all 55 shops */

/* 1. San Remo */
UPDATE shops SET
  specialty = 'Italienisches Urgestein mitten in der Fußgängerzone, direkt an der Nikolaikirche. Das San Remo ist seit vielen Jahren eine feste Institution in Leipzig – ein klassisches Eiscafé mit Straßenterrasse, das auch Pizza, Crêpes und Kaffee anbietet. Die Außenbestuhlung und die zentrale Lage machen es zum idealen Stadtbummel-Stopp. Vor allem im Sommer bilden sich regelmäßig Schlangen – ein gutes Zeichen.',
  location_description = 'Direkt an der Nikolaikirche in der Fußgängerzone; weitere Standorte an der Sachsenbrücke (Eiswagen) und als Take-Away in der Innenstadt. Hervorragende ÖPNV-Anbindung.'
WHERE id::text LIKE '02524fa6%';

/* 2. Softeisbar Leipzig */
UPDATE shops SET
  specialty = 'Kleine Softeisbar am Ostplatz mit täglich wechselnden Geschmacksrichtungen. Das Softeis wird in einer professionellen italienischen Maschine hergestellt – traditionell wie früher, mit sächsischen Rohstoffen. Außerdem gibt es Kugeleis und Kaltgetränke sowie einen Lieferservice für Veranstaltungen. Bewertungen loben die cremige Qualität und das freundliche Personal; der Standort an der vielbefahrenen Kreuzung wird manchmal als Wermutstropfen genannt.',
  location_description = 'An der stark befahrenen Kreuzung am Ostplatz; direkt an der Straßenbahn. Zweiter Standort an der Chemnitzer Straße (Probstheida).'
WHERE id::text LIKE '0374b363%';

/* 3. Zum Pillendreher */
UPDATE shops SET
  specialty = 'Geheimtipp in Stötteritz ohne großen Onlineauftritt, dafür mit tollem selbstgemachtem Eis und einer liebevoll gestalteten Café-Atmosphäre. Das Café dient auch als Kulturort und Treffpunkt im Stadtteil – Lesungen und Veranstaltungen finden hier regelmäßig statt. Wer handgemachtes Eis mit kreativen Sorten und selbstgebackenen Pralinen in urigem Ambiente sucht, ist hier richtig.',
  location_description = 'Ruhige Wohnlage in Stötteritz; gut per Straßenbahn erreichbar (Haltestelle Täubchenweg).'
WHERE id::text LIKE '06d4d73a%';

/* 4. TONIS icecream Thomaskirchhof */
UPDATE shops SET
  specialty = 'TONIS steht für prämiertes, regional handgemachtes Bio-Eis ohne Zusatzstoffe – „Kein Bullshit. Nur Icecream." Das Café am Thomaskirchhof ist der zweite Standort (neben der Könneritzstraße) und bietet hausgemachte Kugeln, vegane und glutenfreie Optionen sowie legendäre Bio-Waffeln. Die Sorten wechseln regelmäßig und reichen von Klassikern bis zu kreativen Kompositionen wie Mango-Guave oder Mais.',
  location_description = 'Direkt am Thomaskirchhof, wenige Schritte von der Thomaskirche; zentrale Innenstadtlage mit sehr guter ÖPNV-Anbindung.'
WHERE id::text LIKE '09efe119%';

/* 5. Eiscafé Oase */
UPDATE shops SET
  specialty = 'Kleines, selbstgemachtes Eiscafé im Süden Leipzigs mit besonderem Fokus auf ungewöhnliche Sorten – etwa Zitrone-Minze mit echter frischer Minze. Faire Preise und herzlicher Service zeichnen diesen Familienbetrieb aus. Gut per ÖPNV erreichbar.',
  location_description = 'Bornaische Straße im südlichen Leipzig; gut per Straßenbahn erreichbar (Linie 9/10).'
WHERE id::text LIKE '0a5c0f8c%';

/* 6. Mario Gelato */
UPDATE shops SET
  specialty = 'Traditionsreiches Eiscafé im Nordosten Leipzigs, das Eis und Deutsche Restaurantküche kombiniert. Begeistert durch ein außergewöhnlich umfangreiches Eisangebot – allein die Auswahl an Spaghettieis-Bechern füllt zwei Seiten. Das Restaurant bietet hausgemachtes Gelato in vielen klassischen und eigenwilligen Kreationen, dazu Kuchen und herzhafte Gerichte. Catering-Service für Veranstaltungen vorhanden.',
  location_description = 'Im Nordosten Leipzigs in Schönefeld; per S-Bahn (S2, Haltestelle Schönefeld) erreichbar.'
WHERE id::text LIKE '11ff8dbe%';

/* 7. Softeisbude */
UPDATE shops SET
  specialty = 'Kleine Softeisbude an der Karl-Heine-Straße in Plagwitz, nah am Karl-Heine-Kanal. Spezialisiert auf veganes und klassisches Softeis zum Mitnehmen – unkompliziert, lecker, erschwinglich.',
  location_description = 'Direkt an der Karl-Heine-Straße, ca. 100 m vom Karl-Heine-Kanal; idealer Zwischenstopp für Spaziergänger entlang des Kanals. Gut per Tram erreichbar.'
WHERE id::text LIKE '130968a1%';

/* 8. LuiLui Eisladen Anger-Crottendorf */
UPDATE shops SET
  specialty = 'Einer der beliebtesten Eisläden Leipzigs, betrieben von Franziska Lehninger seit 2019. Zu 100 % hausgemacht, mit großzügigen Portionen und wechselnden kreativen Sorten von Schokolade bis Gummibärchen und Himbeer-Lavendel. Dieser Standort in der Zweinaundorfer Straße liegt nah an der S-Bahn Anger-Crottendorf. LuiLui hat 4,9 Sterne – einer der höchsten Werte in Leipzig.',
  location_description = 'Zweinaundorfer Straße, nah an der S-Bahn-Haltestelle Anger-Crottendorf; gut erreichbar aus dem Osten der Stadt.'
WHERE id::text LIKE '1dc29c72%';

/* 9. Eisdiele Brakers */
UPDATE shops SET
  specialty = 'Kleiner Nachbarschaftstreffpunkt in Connewitz, spezialisiert auf Softeis. Seit Jahren ein beliebter Anlaufpunkt für das Viertel – unkompliziert, freundlich, mit nostalgie-behaftetem Flair.',
  location_description = 'Bornaische Straße in Connewitz; gut per Tram (Linie 9) erreichbar, fußläufig vom Connewitzer Kreuz.'
WHERE id::text LIKE '20eeb516%';

/* 10. SÜSSKIND.EIS */
UPDATE shops SET
  specialty = 'Das Geheimtipp-Eiscafé am Stadtrand von Leipzig, das viele als das beste Eis der Stadt bezeichnen. Inhaberin Manja stellt jede Sorte selbst her – ohne künstliche Aromen oder Farbstoffe. Obst und Gemüse stammen aus regionalen Gärten. Die Sorten sind kreativ und außergewöhnlich: von Cranberry-Tonic bis Birne-Lavendel. Mit 4,8 Sternen bei 490 Bewertungen ist SÜSSKIND.EIS ein echtes Aushängeschild.',
  location_description = 'Am Grünen Winkel in Lützschena-Stahmeln, direkt an der Weißen Elster; idyllische Auenlage am nördlichen Stadtrand. Anfahrt mit dem Fahrrad über den Elsterradweg empfohlen; per ÖPNV nur eingeschränkt erreichbar.'
WHERE id::text LIKE '21f58e4b%';

/* 11. CN EISCAFE & BISTRO */
UPDATE shops SET
  specialty = 'Gemütliches Eiscafé und Bistro im Westen Leipzigs mit selbstgemachtem Eis, deutschen Hausmannskost-Gerichten und frischem Kuchen. Familiäre Atmosphäre, sehr freundliches Personal und faire Preise. Die Gäste schätzen vor allem das ganzheitliche Angebot aus Eis, Kaffee und Mittagstisch.',
  location_description = 'Ruhige Wohnlage in Miltitz im westlichen Leipzig; kein direkter ÖPNV-Anschluss – Anfahrt mit dem Auto oder Fahrrad empfohlen.'
WHERE id::text LIKE '23280edf%';

/* 12. TONIS icecream KÖ */
UPDATE shops SET
  specialty = 'Das Stammhaus von TONIS an der Könneritzstraße – seit 2003 im Betrieb. Hier begann die Geschichte des Bio-Eises von Toni. Kleiner Laden mit wunderschönem grünem Freisitz, ideal für Groß und Klein. Das Konzept ist identisch mit dem Thomaskirchhof-Standort: prämiertes Bio-Eis, kreative Sorten, vegane und glutenfreie Optionen.',
  location_description = 'Könneritzstraße in Plagwitz, nah am Karl-Heine-Kanal; gut per Tram erreichbar (Haltestelle Nonnenstraße). Zweiter TONIS-Standort am Thomaskirchhof.'
WHERE id::text LIKE '28d2984a%';

/* 13. 034E1S */
UPDATE shops SET
  specialty = 'Kleines Eiscafé mit Mittagstisch-Angebot in Marienbrunn/Connewitz. Täglich wechselnde Sorten, darunter Klassiker und ausgefallene Kreationen wie Kulfi (indisches Eis aus Pistazie, Safran und Kardamom), Apfel-Estragon oder Ananas-Petersilie. Zero-Waste-freundlich – Mehrwegbehälter können mitgebracht werden. 4,9 Sterne bei 53 Bewertungen.',
  location_description = 'Zwickauer Straße im Süden Connewitz/Marienbrunn; per Tram (Linie 9) und Bus erreichbar.'
WHERE id::text LIKE '2c70f8cf%';

/* 14. Gustav H. */
UPDATE shops SET
  specialty = 'Handgemachte Eismanufaktur in Reudnitz, nah am Lene-Voigt-Park. Inhaberin Jana Vogel kreiert außergewöhnliche Sorten wie Heidelbeer-Lavendel, Zitrone-Meringue oder Quark-Sanddorn. Kleine, liebevoll gestaltete Eisdiele mit persönlichem Charakter.',
  location_description = 'Baedekerstraße in Reudnitz, ca. 300 m vom Lene-Voigt-Park; gut per Tram erreichbar (Haltestelle Riebeckstraße). Schwesterstandort: Vanille & Zimt in Connewitz.'
WHERE id::text LIKE '2d284bf3%';

/* 15. Mr. Borella */
UPDATE shops SET
  specialty = 'Direkter Blick auf den Augustusplatz, bunte Schirme und Sitzkissen auf den Stufen – Mr. Borella ist die auffälligste Selfservice-Softeisstation im Stadtzentrum. Das Konzept: unbegrenzte Toppings für einen Fixpreis pro Becher. Beliebt für die einladende Atmosphäre und die Lage.',
  location_description = 'Direkt am Augustusplatz, dem zentralen Platz Leipzigs; unmittelbar an der Oper und gegenüber dem Neuen Gewandhaus. Beste ÖPNV-Lage der Stadt.'
WHERE id::text LIKE '2e39985e%';

/* 16. Thommy''s Eismanufaktur */
UPDATE shops SET
  specialty = 'Eismanufaktur im Nordwesten Leipzigs an der Georg-Schumann-Straße, bekannt für außergewöhnliche und wechselnde Sorten wie Schwarzer Sesam, Ananas-Curry oder Marzipan. Selbstgebackene Waffeln und hoher Qualitätsanspruch. 4,7 Sterne bei 374 Bewertungen.',
  location_description = 'Georg-Schumann-Straße 294 in Wahren; per Tram (Linie 10/11) erreichbar. Nördlich des Stadtteils Gohlis, Richtung Schkeuditz.'
WHERE id::text LIKE '3ae7f90d%';

/* 17. Miltitzer Eiscafé */
UPDATE shops SET
  specialty = 'Kleines Eiscafé im westlichsten Zipfel Leipzigs, direkt am Elsterauengebiet. Bekannt für kreative Sorten wie „Crispy Orange" und „Rose", und empfohlen von vielen Stammgästen. Großer Außenbereich, gemütliche Atmosphäre.',
  location_description = 'Auenweg in Miltitz, direkt am Elsterauengebiet und wenige Schritte von der Weißen Elster; ruhige Naturlage am westlichen Stadtrand. Fahrradtour entlang der Elster legt hier einen natürlichen Stopp nahe.'
WHERE id::text LIKE '3b182b07%';

/* 18. Eis Café Tiziano */
UPDATE shops SET
  specialty = 'Klassisches Eiscafé im Paunsdorf Center-Umfeld mit langer Öffnungszeit und breitem Angebot. 4,3 Sterne bei 2.287 Bewertungen – hohe Besucherzahl durch die Shoppingmall-Lage. Traditionelles Eiscafé mit Sitzplätzen und Café-Betrieb.',
  location_description = 'Nah am Paunsdorf Center im Nordosten Leipzigs; gut per Tram erreichbar (Haltestelle Paunsdorf Center).'
WHERE id::text LIKE '3e937df1%';

/* 19. Shady punkt Leipzig */
UPDATE shops SET
  specialty = 'Kreativer Eisladen in der Südvorstadt mit ungewöhnlichen Flavour-Mixes und Mix-in-Konzept ähnlich zu Ben & Jerry''s – Sorten werden individuell zusammengestellt und mit Toppings versehen. Sitz-Außenbereich abseits der Bahnschienen. Bekannt für Sorten wie Ayran & Mango oder Ayran & Granatapfel.',
  location_description = 'Körnerstraße in der Südvorstadt, abseits der vielbefahrenen Karl-Liebknecht-Straße; gut per Tram erreichbar (Haltestelle Hohe Straße).'
WHERE id::text LIKE '479e2fe3%';

/* 20. Eiscafè Eis-Zapfen */
UPDATE shops SET
  specialty = 'Kleines Eiscafé in der Grünewaldstraße nahe Zentrum, bekannt für ungewöhnliche Sorten wie Duplo, Bacardi, Brezel oder Pistazie. Viele Stammgäste schätzen die kreative Auswahl und den gemütlichen Charakter. Draußen sitzen möglich.',
  location_description = 'Grünewaldstraße, kurze Fußwege vom Hauptbahnhof und vom Augustusplatz; sehr zentrale Lage.'
WHERE id::text LIKE '47dd96f0%';

/* 21. Eiscafé Prinz */
UPDATE shops SET
  specialty = 'Softeis-Spezialist im Musikerviertel, direkt neben dem Clara-Zetkin-Park. Der humorvolle, freundliche Inhaber ist Teil des besonderen Charakters dieses kleinen Ladens. Täglich wechselnde Softeis-Sorten. 4,8 Sterne bei 180 Bewertungen.',
  location_description = 'Sebastian-Bach-Straße im Musikerviertel, unmittelbar neben dem Eingang zum Clara-Zetkin-Park; Spielplätze und Wiesen des Parks direkt nebenan.'
WHERE id::text LIKE '4c7814b2%';

/* 22. Eiscafé Florenz Leipzig */
UPDATE shops SET
  specialty = 'Traditionsreiches Eiscafé seit 1946 in Gohlis an der Georg-Schumann-Straße – eines der ältesten Eiscafés in Leipzig. Mit schönem, schattigem Freisitz im Innenhof, herzlichem Service und selbstgemachtem Eis. Besonders empfohlen: Mozartkugel-Eis und die Windbeutel mit Eis und Erdbeeren. 4,8 Sterne.',
  location_description = 'Georg-Schumann-Straße 72 in Gohlis; gut per Tram erreichbar (Linie 10/11, Haltestelle Coppiplatz). Ruhiger Innenhof als Rückzugsort abseits des Straßenlärms.'
WHERE id::text LIKE '52679e6c%';

/* 23. Eismanufaktur Borkmann */
UPDATE shops SET
  specialty = 'Handgemachte Eismanufaktur in Markkleeberg mit kreativem Sortiment und einem 24/7 verfügbaren Eisautomaten. Rhabarber-Hafervanille und Schokolade als bekannte Sorten. Nachhaltig produziert mit saisonal wechselnden Kreationen.',
  location_description = 'In Markkleeberg südlich von Leipzig, nah am Markkleeberger See (Neuseenland); von Leipzig aus ca. 10 km, gut per S-Bahn erreichbar (S5a, Haltestelle Markkleeberg).'
WHERE id::text LIKE '531bb07e%';

/* 24. Il buon Gelato */
UPDATE shops SET
  specialty = 'Gelateria an der Karl-Heine-Straße in Plagwitz mit einem breiten Sortiment aus klassischen und ausgefallenen Sorten. Bekannt für Pistazie, Lakritze und Zuckerwatte sowie Hundeeis. Gemütliche Atmosphäre, draußen sitzen möglich.',
  location_description = 'Karl-Heine-Straße 58 in Plagwitz, ca. 150 m vom Karl-Heine-Kanal; beliebtes Viertel mit vielen Cafés und Ateliers. Gut per Tram erreichbar.'
WHERE id::text LIKE '5bd3e067%';

/* 25. Café Eisträumerei */
UPDATE shops SET
  specialty = 'Beliebtes Eiscafé im Osten Leipzigs mit hauseigener „Eiswerkstatt". Neben Klassikern wie Schokolade und Vanille gibt es immer wieder exotische Sorten wie Schwarzbier, Kürbis oder Knusperflocken. Vegane und laktosefreie Optionen vorhanden. Familienfreundliche Atmosphäre, hausgemachte Kuchen. 4,5 Sterne bei 934 Bewertungen.',
  location_description = 'Riebeckstraße in Reudnitz-Thonberg; gut per Tram erreichbar (Haltestelle Riebeckstraße). Nah am Ostplatz.'
WHERE id::text LIKE '5c5c57ac%';

/* 26. Softi to go */
UPDATE shops SET
  specialty = 'Kleiner Softeis-Stand in der Wurzner Straße im Osten Leipzigs, spezialisiert auf Softeis mit verschiedenen Geschmackskombinationen zu fairen Preisen. In einer Gegend mit wenigen Eisdielen eine willkommene Anlaufstelle.',
  location_description = 'Wurzner Straße in Neuschönefeld; gut per Tram erreichbar (Linie 3). Grünfläche in unmittelbarer Nähe.'
WHERE id::text LIKE '60d2bd86%';

/* 27. Kännchenklein */
UPDATE shops SET
  specialty = 'Gemütliches Café im Zentrum mit Selfservice-Softeis, Karamell und Schokolade als Hauptsorten. Toppings und Saucen nach Wahl inklusive. Kleine, gemütliche Atmosphäre, freundliches Personal.',
  location_description = 'Grimmaische Straße im Stadtzentrum; fußläufig vom Augustusplatz und Markt.'
WHERE id::text LIKE '66921bbc%';

/* 28. Gusto Italiano Eiscafé */
UPDATE shops SET
  specialty = 'Klassisches italienisches Eiscafé am Grimmaischen Steinweg. Einfaches Konzept mit traditionellen Eissorten und Café-Betrieb. Zentrale Lage.',
  location_description = 'Grimmaischer Steinweg, direkt in der Innenstadt; fußläufig von der Nikolaikirche und der Mädlerpassage.'
WHERE id::text LIKE '6cd593e6%';

/* 29. BECHER.ODER.WAFFEL */
UPDATE shops SET
  specialty = 'Liebevoll gestaltetes Eiscafé in Reudnitz, bekannt für wunderschön dekorierte Eisbecher und aufwendige Eisspezialitäten. Nach einer Renovierung noch ansprechender. 4,6 Sterne bei 199 Bewertungen.',
  location_description = 'Ruhige Wohnstraße in Reudnitz-Thonberg; per Tram erreichbar (Haltestelle Riebeckstraße oder Ostplatz).'
WHERE id::text LIKE '6e55bd4a%';

/* 30. Streit''s Gelato */
UPDATE shops SET
  specialty = 'Kleines Eiscafé und Rolleis-Spezialist im Südwesten Leipzigs, bekannt für aufwendig gefertigtes Rolleis und eine riesige Auswahl an liebevollen Eissorten. 4,9 Sterne bei 276 Bewertungen. Vollständig vegane Optionen, bio-zertifiziert.',
  location_description = 'Ratzelstraße in Großzschocher im Südwesten Leipzigs; per Bus erreichbar, kein direkter Tram-Anschluss. Ruhige Randlage.'
WHERE id::text LIKE '6ea22c6e%';

/* 31. Eiscafé Eisflöckchen */
UPDATE shops SET
  specialty = 'Kleines Eiscafé im Süden Leipzigs, besonders bekannt für leckere Waffeln und Kräppelchen neben dem Eis. Familiäre Atmosphäre. 4,5 Sterne.',
  location_description = 'Franzosenallee in Probstheida im südlichen Leipzig; per Bus erreichbar (Linie 74/76). Ruhige Wohnlage ohne direkten Parkbezug.'
WHERE id::text LIKE '73e75bb7%';

/* 32. Anna''s Eisschleckerei */
UPDATE shops SET
  specialty = 'Kleine Gelateria in Markkleeberg mit außergewöhnlich gutem handgemachtem Eis. 5,0 Sterne (10 Bewertungen). Selten bewertetes Kleinod südlich von Leipzig.',
  location_description = 'In Markkleeberg südlich von Leipzig; nah am Markkleeberger See (Neuseenland). Per S-Bahn erreichbar (S5a).'
WHERE id::text LIKE '7a272060%';

/* 33. LuiLui Eisladen Lindenau */
UPDATE shops SET
  specialty = 'Der ursprüngliche LuiLui-Standort in Lindenau an der Georg-Schwarz-Straße. Selbstgemachtes Eis, wechselnde Sorten, vegane Optionen und hausgemachte Waffeln mit „Schnickschnack" (Toppings). Direkt an der Straßenbahn-Haltestelle Diakonissenhaus. 4,6 Sterne bei 250 Bewertungen.',
  location_description = 'Georg-Schwarz-Straße 64 in Lindenau, direkt an der Tram-Haltestelle Diakonissenhaus (Linie 7/8); lebendigste Einkaufsstraße im westlichen Leipzig.'
WHERE id::text LIKE '7a451585%';

/* 34. Crêpeland */
UPDATE shops SET
  specialty = 'Spezialisiert auf frische, großzügig portionierte Crêpes – das Eis ist hier Ergänzung zum Hauptprodukt. Sehr gemütliche Atmosphäre, 4,9 Sterne bei 259 Bewertungen. In der Merseburger Straße in Plagwitz.',
  location_description = 'Merseburger Straße in Plagwitz, unweit des Karl-Heine-Kanals; gut per Tram erreichbar (Haltestelle Angerbrücke).'
WHERE id::text LIKE '7ee0c1ba%';

/* 35. La Luna */
UPDATE shops SET
  specialty = 'Klassisches Eiscafé am Brühl im Zentrum mit breitem Angebot und langen Öffnungszeiten. Über 580 Bewertungen, 4,0 Sterne.',
  location_description = 'Brühl 1 im Stadtzentrum, unmittelbar neben dem Brühl-Einkaufszentrum und nah am Hauptbahnhof.'
WHERE id::text LIKE '7ee17125%';

/* 36. JJ Softeis */
UPDATE shops SET
  specialty = 'Schöner Softeis-Laden in Lausen nahe dem Kulkwitzer See – idealer Stopp nach dem Baden. Stilvolles, gemütliches Interieur, freundliches Personal und eine große Auswahl an Softeis-Bechern und Sorten. 4,8 Sterne bei 459 Bewertungen.',
  location_description = 'Lausener Straße in Lausen-Grünau, ca. 800 m vom Kulkwitzer See; idealer Anlaufpunkt nach dem Baden oder Spaziergang am Westufer. Kein direkter ÖPNV; Anfahrt per Fahrrad oder Auto empfohlen.'
WHERE id::text LIKE '85803131%';

/* 37. Eiscafé Sabine */
UPDATE shops SET
  specialty = 'Kleines, unscheinbares Café nahe der Leinestraße im Süden Leipzigs. Breite Auswahl an Torten und Kuchen neben Eis – besonders beliebt am Wochenende. Nah am Agra-Park. 4,5 Sterne bei 563 Bewertungen.',
  location_description = 'Leinestraße im südlichen Dölitz-Dösen, ca. 500 m vom Agra-Park und der Veranstaltungshalle Agra; per Bus erreichbar (Linie 60/70).'
WHERE id::text LIKE '8f2153b2%';

/* 38. Mein Eis Leipzig */
UPDATE shops SET
  specialty = 'Eisdiele in Gohlis nah am Zoologischen Garten Leipzig. Selbstgemachte Sorten mit natürlichen Zutaten, darunter indische Spezialitäten wie Kulfi. Wechselnde und saisonale Sorten. 4,7 Sterne bei 257 Bewertungen.',
  location_description = 'Karl-Rothe-Straße in Gohlis, ca. 300 m vom Eingang des Zoologischen Gartens Leipzig; hervorragend geeignet als Eisstation vor oder nach dem Zoo-Besuch. Gut per Tram erreichbar (Linie 12).'
WHERE id::text LIKE '9049bdf9%';

/* 39. FREDO eis, hot dogs & co. */
UPDATE shops SET
  specialty = 'Veganer Eisladen nahe der Eisenbahnstraße mit Softeis, Hot Dogs, Waffeln und saisonalen Angeboten. Sehr hohes Qualitätsniveau, 4,9 Sterne bei 134 Bewertungen. Vollständig vegan, auch Glühwein im Winter.',
  location_description = 'Hermann-Liebmann-Straße, nah an der kulturell vielfältigen Eisenbahnstraße im Osten Leipzigs; gut per Tram erreichbar (Linie 3/7, Haltestelle Eisenbahnstraße).'
WHERE id::text LIKE '94699345%';

/* 40. Eisautomat Holzhausen */
UPDATE shops SET
  specialty = 'Einzigartiger 24/7-Eisautomat im Südosten Leipzigs. Hochwertiges Eis aus Milch von Weidekühen, nachhaltig produziert. Perfekt für nächtlichen Eisgenuss und Spontankäufe.',
  location_description = 'Holzhausen im südöstlichen Leipzig; kein direkter ÖPNV-Anschluss – Anfahrt per Auto oder Fahrrad empfohlen. Einziger Eisautomat in diesem Bereich.'
WHERE id::text LIKE '95aa9eb3%';

/* 41. Eisbrennerei */
UPDATE shops SET
  specialty = 'Die Eisbrennerei auf der Karli ist die einzige Eisdiele Leipzigs mit einem Alkohol-Eis-Sortiment – „Kugelcocktails". Täglich 8 wechselnde alkoholische Sorten (z. B. Schoko-Karamell-Whiskey, Gin-Basilikum-Zitronensorbet, White Russian) neben alkoholfreiem und veganem Eis. Hausgemacht, ohne Aromen und Farbstoffe. Sehr beliebt, teils 10–15 Minuten Wartezeit. 4,8 Sterne bei 703 Bewertungen.',
  location_description = 'Karl-Liebknecht-Straße 97 in der Südvorstadt, auf der belebtesten Ausgehmeile Leipzigs; direkt an der Tram (Haltestelle Hohe Straße). Bester Standort für einen Abend-Eis-Stopp.'
WHERE id::text LIKE 'a12b4cb2%';

/* 42. Eiscafé La Luna – Paunsdorf Center */
UPDATE shops SET
  specialty = 'Eiscafé innerhalb des Paunsdorf Centers – der größten Shoppingmall im Osten Leipzigs. Gut erreichbar, breites klassisches Angebot mit Sitzplätzen innen. 4,3 Sterne bei 534 Bewertungen.',
  location_description = 'Im Erdgeschoss des Paunsdorf Centers, der größten Shoppingmall Ostdeutschlands; direkt an der Tram (Linie 3/7, Haltestelle Paunsdorf Center). Wetterfest und barrierefrei zugänglich.'
WHERE id::text LIKE 'aa9cb036%';

/* 43. Softeisbar Chemnitzer Straße */
UPDATE shops SET
  specialty = 'Zweiter Standort der Softeisbar Leipzig an der Chemnitzer Straße. DDR-Traditionssofteis, täglich wechselnde Sorten. Außensitzbereich. 4,8 Sterne bei 81 Bewertungen.',
  location_description = 'Chemnitzer Straße in Probstheida im südlichen Leipzig; gut per Tram erreichbar (Linie 9, Haltestelle Probstheida). Hauptstandort der Softeisbar am Ostplatz.'
WHERE id::text LIKE 'b3e806f2%';

/* 44. Vanille & Zimt Eismanufaktur */
UPDATE shops SET
  specialty = 'Handgemachte Eismanufaktur von Jana Vogel in Connewitz, nah am Hildebrandtplatz. Direkt an einer Straßenbahnlinie. Das Eis schmeckt nach echten Zutaten – kein Kunstgeschmack. Kreative Sorten, faire Preise. 4,7 Sterne bei 293 Bewertungen.',
  location_description = 'Bornaische Straße in Connewitz, ca. 200 m vom Hildebrandtplatz; direkt an der Tram (Linie 9). Schwesterstandort: Gustav H. in Reudnitz.'
WHERE id::text LIKE 'b3f893ef%';

/* 45. Sodann''s Softeis Wiederitzsch */
UPDATE shops SET
  specialty = 'Softeis-Café im Norden Leipzigs in Wiederitzsch. Gute Auswahl, bekannt für To-go Tiefkühlsorten zum Mitnehmen nach Hause. 4,6 Sterne bei 204 Bewertungen.',
  location_description = 'In Wiederitzsch im nördlichen Leipzig; gut per S-Bahn erreichbar (S1, Haltestelle Wiederitzsch). Einzige Softeis-Option in diesem Bereich.'
WHERE id::text LIKE 'b49e951a%';

/* 46. Softeis Eugen Hendrich */
UPDATE shops SET
  specialty = 'Kleiner Softeis-Stand in der Waldstraße im Waldstraßenviertel/Gohlis. Von Stammgästen als „bestes Softeis in Leipzig" bezeichnet mit täglichen Geschmacksvariationen. 4,7 Sterne bei 358 Bewertungen.',
  location_description = 'Waldstraße im Waldstraßenviertel, einem der beliebtesten Wohnviertel Leipzigs; gut per Tram erreichbar (Linie 12/16).'
WHERE id::text LIKE 'bb53760b%';

/* 47. Softeis Lindenthaler Straße */
UPDATE shops SET
  specialty = 'Kleiner Softeis-Laden in Gohlis an der Lindenthaler Straße. Puristisches Konzept, täglich wechselnde Sorten. 4,7 Sterne bei 23 Bewertungen.',
  location_description = 'Lindenthaler Straße in Gohlis; gut per Tram oder Bus erreichbar. Wenige Minuten vom Softeis Eugen Hendrich entfernt.'
WHERE id::text LIKE 'c57e72c7%';

/* 48. Dolce Freddo Eismanufaktur */
UPDATE shops SET
  specialty = 'Eiscafé im Hauptbahnhof-Bereich am Willy-Brandt-Platz. Bekannt für außergewöhnlich schnellen Service trotz hoher Auslastung und perfekt dekorierte Eisbecher. Klassisches Eiscafé-Sortiment, auch vegane Optionen. 4,2 Sterne bei 459 Bewertungen.',
  location_description = 'Willy-Brandt-Platz direkt vor dem Hauptbahnhof Leipzig; bestmögliche ÖPNV-Lage – alle Tram- und Buslinien erreichbar, direkt neben dem größten Kopfbahnhof Europas.'
WHERE id::text LIKE 'caf77a60%';

/* 49. Eis Oase */
UPDATE shops SET
  specialty = 'Kleine Eisdiele am Rabet im Osten Leipzigs. Freundlicher Service, Kinder bekommen Kugeln zum halben Preis. Neben Standardsorten auch gelegentlich außergewöhnliche Kreationen. 4,6 Sterne bei 57 Bewertungen.',
  location_description = 'Rabet 44 in Neuschönefeld, direkt neben dem Rabet-Park mit Spielplatz und Grünfläche; gut per Tram erreichbar (Linie 3, Haltestelle Rabet).'
WHERE id::text LIKE 'cba59bdc%';

/* 50. Milchbar Pinguin */
UPDATE shops SET
  specialty = 'Kultcafé mitten in der Innenstadt mit großer Terrasse und einem breiten Angebot von Frühstück über Kuchen bis zu Eisbechern und Cocktails. Legendäre Bekanntheit in Leipzig, über 5.000 Google-Bewertungen. 4,1 Sterne – der Betrieb ist groß und entsprechend schwankend in der Qualität, aber die Lage und das Angebot sind einzigartig.',
  location_description = 'Katharinenstraße in der Innenstadt, zwischen Markt und Augustusplatz; eine der zentralsten Lagen Leipzigs, wenige Schritte von der Mädlerpassage.'
WHERE id::text LIKE 'db823e46%';

/* 51. Eisdiele am See */
UPDATE shops SET
  specialty = 'Handgemachte Eisdiele nahe einem See im Westen Leipzigs. Kreative Sorten wie Schokolade-Chili und Schoko-Marzipan. Besondere Lage direkt am Wasser. 4,5 Sterne bei 267 Bewertungen.',
  location_description = 'Staffelsteinstraße in Miltitz, direkt an einem kleinen See im westlichen Leipzig; Naturlage, Anfahrt per Fahrrad oder Auto empfohlen. Kein direkter ÖPNV.'
WHERE id::text LIKE 'e5145fdb%';

/* 52. Mamalicious */
UPDATE shops SET
  specialty = 'Kombiniertes Eis- und Döner-Café in der Riebeckstraße. Unklare Fokussierung laut Bewertungen, aber für Süßes und Herzhafte zugleich geeignet. 3,7 Sterne bei 21 Bewertungen.',
  location_description = 'Riebeckstraße in Reudnitz-Thonberg; gut per Tram erreichbar (Haltestelle Riebeckstraße).'
WHERE id::text LIKE 'f2a521f6%';

/* 53. likken */
UPDATE shops SET
  specialty = 'Kultladen auf der Karli mit dem markantesten Merkmal Leipzigs: die pechschwarzen, mit Pflanzenkohle gefärbten Waffeln. 9 täglich wechselnde Eissorten von Milchreis bis Omas Teigschüssel oder Schwarze Kokosnuss – alles kreativ, alles hausgemacht. Vegane Sorten und Softeis ganzjährig. Gegründet von Phil, Togi und Julius. 4,7 Sterne bei 152 Bewertungen.',
  location_description = 'Karl-Liebknecht-Straße 105 in der Südvorstadt, auf der Karli – der lebhaftesten Ausgehmeile Leipzigs; direkt an der Tram (Haltestelle Südplatz). Flaniermeile mit Außengastronomie ringsum.'
WHERE id::text LIKE 'f3c5087a%';

/* 54. Eisdiele Pfeifer */
UPDATE shops SET
  specialty = 'Familiäre Eisdiele auf der Kochstraße in der Südvorstadt. Handgemachtes Eis mit authentischem Flair und hausgemachtem Kuchen. Seit vielen Jahren ein fester Bestandteil des Viertels. 4,5 Sterne bei 494 Bewertungen.',
  location_description = 'Kochstraße in der Südvorstadt, eine ruhige Nebenstraße der Karl-Liebknecht-Straße; gut per Tram erreichbar (Haltestelle Südplatz oder Hohe Straße).'
WHERE id::text LIKE 'f68ed2d0%';

/* 55. Erikas Eiscafé Eutritzsch */
UPDATE shops SET
  specialty = 'Das zweite Café von Erika – das erste ist in Gohlis-Nord. Das Eis kommt direkt von Manja (SÜSSKIND.EIS), der besten Freundin der Inhaberin. Bubble-Waffeln, selbstgemachte Limonaden, Milchshakes und wechselnde Sorten wie Rhabarber-Joghurt oder Kürbiskern. Auch Frühstück am Wochenende und ein Büchertauschregal. 4,8 Sterne bei 308 Bewertungen.',
  location_description = 'Schiebestraße in Eutritzsch im nördlichen Leipzig; gut per S-Bahn erreichbar (S1, Haltestelle Leipzig-Eutritzsch). Ruhiges Wohnviertel, nördlich von Gohlis.'
WHERE id::text LIKE 'f9cc49b2%';
