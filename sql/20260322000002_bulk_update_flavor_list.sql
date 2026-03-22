/* Bulk update flavor_list for all shops and drop signature_flavors column */

/* 1. San Remo */
UPDATE shops SET flavor_list = '[{"name": "Gianduja", "tag": "signatur"}, {"name": "Zitrone"}, {"name": "Pistazie"}, {"name": "Stracciatella"}, {"name": "Schokolade"}, {"name": "Erdbeer"}, {"name": "Vanille"}]'::jsonb
WHERE id::text LIKE '02524fa6%';

/* 2. Softeisbar Leipzig — MERGE: md + 3 extra DB entries */
UPDATE shops SET flavor_list = '[{"name": "Vanille", "tag": "softeis"}, {"name": "Aprikose-Vanille", "tag": "softeis"}, {"name": "Erdbeere-Vanille", "tag": "softeis"}, {"name": "Himbeere-Vanille", "tag": "softeis"}, {"name": "Heidelbeere-Vanille", "tag": "softeis"}, {"name": "Kirsch-Vanille", "tag": "softeis"}, {"name": "Mango-Vanille", "tag": "softeis"}, {"name": "Schoko-Vanille", "tag": "softeis"}, {"name": "Schoko", "tag": "softeis"}, {"name": "Joghurt", "tag": "softeis"}, {"name": "Erdbeere-Joghurt", "tag": "softeis"}]'::jsonb
WHERE id::text LIKE '0374b363%';

/* 3. Zum Pillendreher */
UPDATE shops SET flavor_list = '[{"name": "Schokolade"}, {"name": "Pistazie"}, {"name": "Haselnuss"}, {"name": "Vanille"}, {"name": "Erdbeere"}, {"name": "Saisonsorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE '06d4d73a%';

/* 4. TONIS icecream Thomaskirchhof */
UPDATE shops SET flavor_list = '[{"name": "Mango-Guave", "tag": "vegan"}, {"name": "Matcha Brownie", "tag": "bio"}, {"name": "Mais", "tag": "exotisch"}, {"name": "Banane-Schoko-Haselnuss", "tag": "bio"}, {"name": "Grapefruit-Orange", "tag": "sorbet"}, {"name": "Olive-Zitrone", "tag": "exotisch"}, {"name": "Apfel Crumble", "tag": "saisonal"}, {"name": "Vanille", "tag": "bio"}, {"name": "Schokolade", "tag": "bio"}, {"name": "Pistazie", "tag": "bio"}]'::jsonb
WHERE id::text LIKE '09efe119%';

/* 5. Eiscafé Oase */
UPDATE shops SET flavor_list = '[{"name": "Zitrone-Minze", "tag": "signatur"}, {"name": "Erdbeer"}, {"name": "Schokolade"}, {"name": "Vanille"}, {"name": "Saisonsorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE '0a5c0f8c%';

/* 6. Mario Gelato */
UPDATE shops SET flavor_list = '[{"name": "Spaghettieis", "tag": "signatur"}, {"name": "Erdbeer"}, {"name": "Schokolade"}, {"name": "Pistazie"}, {"name": "Vanille"}, {"name": "Sahne"}, {"name": "Saisonsorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE '11ff8dbe%';

/* 7. Softeisbude */
UPDATE shops SET flavor_list = '[{"name": "Schoko-Vanille", "tag": "softeis"}, {"name": "Veganes Softeis", "tag": "vegan"}, {"name": "Wechselnde Sorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE '130968a1%';

/* 8. LuiLui Eisladen Anger-Crottendorf */
UPDATE shops SET flavor_list = '[{"name": "Himbeer-Lavendel", "tag": "signatur"}, {"name": "Schokolade"}, {"name": "Himbeere"}, {"name": "Mango", "tag": "vegan"}, {"name": "Zitrone-Vanille"}, {"name": "Eiskaffee"}, {"name": "Brownie"}, {"name": "Banana-Split"}, {"name": "Gummibärchen"}, {"name": "Vegane Sorten", "tag": "vegan"}]'::jsonb
WHERE id::text LIKE '1dc29c72%';

/* 9. Eisdiele Brakers */
UPDATE shops SET flavor_list = '[{"name": "Softeis klassisch", "tag": "softeis"}, {"name": "Vanille"}, {"name": "Schokolade"}]'::jsonb
WHERE id::text LIKE '20eeb516%';

/* 10. SÜSSKIND.EIS */
UPDATE shops SET flavor_list = '[{"name": "Cranberry-Tonic", "tag": "signatur"}, {"name": "Birne-Lavendel", "tag": "signatur"}, {"name": "Kefir-Heidelbeere", "tag": "exotisch"}, {"name": "Heidelbeer-Lavendel"}, {"name": "Zitrone-Meringue"}, {"name": "Quark-Sanddorn"}, {"name": "Waldfrucht-Lavendel"}, {"name": "Apfelmus-Eierlikör"}, {"name": "Saisonsorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE '21f58e4b%';

/* 11. CN EISCAFE & BISTRO */
UPDATE shops SET flavor_list = '[{"name": "Klassische Sorten"}, {"name": "Wechselnde Spezialitäten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE '23280edf%';

/* 12. TONIS icecream KÖ */
UPDATE shops SET flavor_list = '[{"name": "Gurke-Tonic", "tag": "signatur"}, {"name": "Cookie Dough", "tag": "bio"}, {"name": "Haselnuss", "tag": "bio"}, {"name": "Pistazie", "tag": "bio"}, {"name": "Schokolade", "tag": "bio"}, {"name": "Vanille", "tag": "bio"}, {"name": "Mango-Guave", "tag": "vegan"}, {"name": "Bio-Sorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE '28d2984a%';

/* 13. 034E1S */
UPDATE shops SET flavor_list = '[{"name": "Kulfi", "tag": "signatur"}, {"name": "Orange-Minze", "tag": "exotisch"}, {"name": "Apfel-Estragon", "tag": "exotisch"}, {"name": "Ananas-Petersilie", "tag": "exotisch"}, {"name": "Erdbeere"}, {"name": "Schokolade"}, {"name": "Tagessorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE '2c70f8cf%';

/* 14. Gustav H. */
UPDATE shops SET flavor_list = '[{"name": "Heidelbeer-Lavendel", "tag": "signatur"}, {"name": "Zitrone-Meringue", "tag": "signatur"}, {"name": "Quark-Sanddorn", "tag": "exotisch"}, {"name": "Waldfrucht-Lavendel"}, {"name": "Kreative Sorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE '2d284bf3%';

/* 15. Mr. Borella */
UPDATE shops SET flavor_list = '[{"name": "Schwarze Kokosnuss", "tag": "signatur"}, {"name": "Vanille", "tag": "softeis"}, {"name": "Schoko", "tag": "softeis"}, {"name": "Wechselnde Softeis-Sorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE '2e39985e%';

/* 16. Thommy's Eismanufaktur */
UPDATE shops SET flavor_list = '[{"name": "Schwarzer Sesam", "tag": "signatur"}, {"name": "Ananas-Curry", "tag": "signatur"}, {"name": "Marzipan", "tag": "exotisch"}, {"name": "Zitrone-Minze"}, {"name": "Schokolade"}, {"name": "Kreative Sorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE '3ae7f90d%';

/* 17. Miltitzer Eiscafé */
UPDATE shops SET flavor_list = '[{"name": "Crispy Orange", "tag": "signatur"}, {"name": "Rose", "tag": "signatur"}, {"name": "Erdbeer"}, {"name": "Schokolade"}, {"name": "Vanille"}, {"name": "Saisonsorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE '3b182b07%';

/* 18. Eis Café Tiziano */
UPDATE shops SET flavor_list = '[{"name": "Erdbeer"}, {"name": "Schokolade"}, {"name": "Pistazie"}, {"name": "Vanille"}, {"name": "Sahne"}]'::jsonb
WHERE id::text LIKE '3e937df1%';

/* 19. Shady punkt Leipzig */
UPDATE shops SET flavor_list = '[{"name": "Ayran & Mango", "tag": "signatur"}, {"name": "Ayran & Granatapfel", "tag": "signatur"}, {"name": "Kreative Mix-in-Sorten", "tag": "exotisch"}]'::jsonb
WHERE id::text LIKE '479e2fe3%';

/* 20. Eiscafè Eis-Zapfen */
UPDATE shops SET flavor_list = '[{"name": "Duplo", "tag": "signatur"}, {"name": "Bacardi", "tag": "alkohol"}, {"name": "Brezel", "tag": "exotisch"}, {"name": "Pistazie"}, {"name": "Schokolade"}, {"name": "Kreative Sorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE '47dd96f0%';

/* 21. Eiscafé Prinz */
UPDATE shops SET flavor_list = '[{"name": "Wechselnde Softeis-Sorten täglich", "tag": "softeis"}]'::jsonb
WHERE id::text LIKE '4c7814b2%';

/* 22. Eiscafé Florenz Leipzig */
UPDATE shops SET flavor_list = '[{"name": "Mozartkugeleis", "tag": "signatur"}, {"name": "Dubai (Schokolade-Pistazie)", "tag": "signatur"}, {"name": "Erdbeer"}, {"name": "Schokolade"}, {"name": "Vanille"}, {"name": "Saisonsorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE '52679e6c%';

/* 23. Eismanufaktur Borkmann */
UPDATE shops SET flavor_list = '[{"name": "Rhabarber-Hafervanille", "tag": "signatur"}, {"name": "Schokolade"}, {"name": "Saisonsorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE '531bb07e%';

/* 24. Il buon Gelato — includes Pokemon from signature_flavors */
UPDATE shops SET flavor_list = '[{"name": "Lakritze", "tag": "signatur"}, {"name": "Zuckerwatte", "tag": "exotisch"}, {"name": "Pokemon", "tag": "exotisch"}, {"name": "Pistazie"}, {"name": "Schokolade"}, {"name": "Vanille"}]'::jsonb
WHERE id::text LIKE '5bd3e067%';

/* 25. Café Eisträumerei */
UPDATE shops SET flavor_list = '[{"name": "Schwarzbier", "tag": "signatur"}, {"name": "Kürbis", "tag": "saisonal"}, {"name": "Lakritze", "tag": "exotisch"}, {"name": "Oreo"}, {"name": "Knusperflocken"}, {"name": "Nougat"}, {"name": "Schokolade"}, {"name": "Vanille"}, {"name": "Erdbeer"}, {"name": "Vegane Sorbets", "tag": "sorbet"}]'::jsonb
WHERE id::text LIKE '5c5c57ac%';

/* 26. Softi to go */
UPDATE shops SET flavor_list = '[{"name": "Vanille", "tag": "softeis"}, {"name": "Schoko", "tag": "softeis"}]'::jsonb
WHERE id::text LIKE '60d2bd86%';

/* 27. Kännchenklein */
UPDATE shops SET flavor_list = '[{"name": "Karamell", "tag": "softeis"}, {"name": "Schokolade", "tag": "softeis"}, {"name": "Vanille"}]'::jsonb
WHERE id::text LIKE '66921bbc%';

/* 28. Gusto Italiano Eiscafé */
UPDATE shops SET flavor_list = '[{"name": "Pistazie"}, {"name": "Erdbeer"}, {"name": "Schokolade"}, {"name": "Vanille"}, {"name": "Klassische Gelato-Sorten"}]'::jsonb
WHERE id::text LIKE '6cd593e6%';

/* 29. BECHER.ODER.WAFFEL */
UPDATE shops SET flavor_list = '[{"name": "Erdbeer"}, {"name": "Amarena", "tag": "signatur"}, {"name": "Schokolade"}, {"name": "Vanille"}, {"name": "Wechselnde Sorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE '6e55bd4a%';

/* 30. Streit's Gelato */
UPDATE shops SET flavor_list = '[{"name": "Rolleis", "tag": "signatur"}, {"name": "Vegane Sorten", "tag": "vegan"}, {"name": "Bio-Kreationen", "tag": "bio"}, {"name": "Wechselnde Sorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE '6ea22c6e%';

/* 31. Eiscafé Eisflöckchen */
UPDATE shops SET flavor_list = '[{"name": "Erdbeer"}, {"name": "Schokolade"}, {"name": "Vanille"}, {"name": "Klassische Sorten"}]'::jsonb
WHERE id::text LIKE '73e75bb7%';

/* 32. Anna's Eisschleckerei */
UPDATE shops SET flavor_list = '[{"name": "Handgemachtes Gelato", "tag": "signatur"}, {"name": "Wechselnde Sorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE '7a272060%';

/* 33. LuiLui Eisladen Lindenau */
UPDATE shops SET flavor_list = '[{"name": "Himbeer-Lavendel", "tag": "signatur"}, {"name": "Schokolade"}, {"name": "Mango", "tag": "vegan"}, {"name": "Gummibärchen"}, {"name": "Erdbeer"}, {"name": "Vegane Sorten", "tag": "vegan"}, {"name": "Kreative Sorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE '7a451585%';

/* 34. Crêpeland */
UPDATE shops SET flavor_list = '[{"name": "Klassische Sorten (als Crêpes-Topping)"}]'::jsonb
WHERE id::text LIKE '7ee0c1ba%';

/* 35. La Luna */
UPDATE shops SET flavor_list = '[{"name": "Pistazie"}, {"name": "Erdbeer"}, {"name": "Schokolade"}, {"name": "Klassische Gelato-Sorten"}]'::jsonb
WHERE id::text LIKE '7ee17125%';

/* 36. JJ Softeis */
UPDATE shops SET flavor_list = '[{"name": "Wechselnde Softeis-Sorten", "tag": "softeis"}]'::jsonb
WHERE id::text LIKE '85803131%';

/* 37. Eiscafé Sabine */
UPDATE shops SET flavor_list = '[{"name": "Erdbeer"}, {"name": "Schokolade"}, {"name": "Vanille"}, {"name": "Klassische Sorten"}]'::jsonb
WHERE id::text LIKE '8f2153b2%';

/* 38. Mein Eis Leipzig */
UPDATE shops SET flavor_list = '[{"name": "Kulfi", "tag": "signatur"}, {"name": "Heidelbeer-Lavendel"}, {"name": "Coffee Crunch"}, {"name": "Milchreis", "tag": "exotisch"}, {"name": "Saisonsorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE '9049bdf9%';

/* 39. FREDO eis, hot dogs & co. */
UPDATE shops SET flavor_list = '[{"name": "Veganes Softeis", "tag": "vegan"}, {"name": "Vegane Sorten", "tag": "vegan"}]'::jsonb
WHERE id::text LIKE '94699345%';

/* 40. Eisautomat Holzhausen */
UPDATE shops SET flavor_list = '[{"name": "Schokolade", "tag": "bio"}, {"name": "Wechselnde Automatensorten"}]'::jsonb
WHERE id::text LIKE '95aa9eb3%';

/* 41. Eisbrennerei */
UPDATE shops SET flavor_list = '[{"name": "Schoko-Karamell-Whiskey", "tag": "alkohol"}, {"name": "White Russian", "tag": "alkohol"}, {"name": "Gin-Basilikum-Zitronensorbet", "tag": "alkohol"}, {"name": "Lillet-Wildberry", "tag": "alkohol"}, {"name": "Erdbeer-Daiquiri", "tag": "alkohol"}, {"name": "Mango-Margarita", "tag": "alkohol"}, {"name": "Aperol-Blutorange-Spritz", "tag": "alkohol"}, {"name": "Weißer Kaffee-Licor 43", "tag": "alkohol"}, {"name": "Gin-Tonic-Heidelbeere", "tag": "alkohol"}, {"name": "Johannisbeere", "tag": "vegan"}, {"name": "Salziges Karamell-Brezel", "tag": "signatur"}, {"name": "Hot Brownie"}, {"name": "Avocado-Limette", "tag": "vegan"}, {"name": "Honig-Lavendel"}]'::jsonb
WHERE id::text LIKE 'a12b4cb2%';

/* 42. Eiscafé La Luna – Paunsdorf Center */
UPDATE shops SET flavor_list = '[{"name": "Erdbeer"}, {"name": "Schokolade"}, {"name": "Pistazie"}, {"name": "Vanille"}, {"name": "Klassische Sorten"}]'::jsonb
WHERE id::text LIKE 'aa9cb036%';

/* 43. Softeisbar Chemnitzer Straße */
UPDATE shops SET flavor_list = '[{"name": "DDR-Softeis", "tag": "signatur"}, {"name": "Wechselnde Sorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE 'b3e806f2%';

/* 44. Vanille & Zimt Eismanufaktur */
UPDATE shops SET flavor_list = '[{"name": "Heidelbeer-Lavendel", "tag": "signatur"}, {"name": "Zitrone-Meringue", "tag": "signatur"}, {"name": "Quark-Sanddorn", "tag": "exotisch"}, {"name": "Waldfrucht-Lavendel"}, {"name": "Kreative Sorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE 'b3f893ef%';

/* 45. Sodann's Softeis Wiederitzsch */
UPDATE shops SET flavor_list = '[{"name": "Softeis in verschiedenen Sorten", "tag": "softeis"}, {"name": "Wechselnde Sorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE 'b49e951a%';

/* 46. Softeis Eugen Hendrich */
UPDATE shops SET flavor_list = '[{"name": "Schoko-Vanille", "tag": "softeis"}, {"name": "Tägliche Wechselsorte", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE 'bb53760b%';

/* 47. Softeis Lindenthaler Straße */
UPDATE shops SET flavor_list = '[{"name": "Schoko", "tag": "softeis"}, {"name": "Vanille", "tag": "softeis"}]'::jsonb
WHERE id::text LIKE 'c57e72c7%';

/* 48. Dolce Freddo Eismanufaktur */
UPDATE shops SET flavor_list = '[{"name": "Erdbeere"}, {"name": "Schokolade"}, {"name": "Pistazie"}, {"name": "Vanille"}, {"name": "Klassische Sorten"}]'::jsonb
WHERE id::text LIKE 'caf77a60%';

/* 49. Eis Oase */
UPDATE shops SET flavor_list = '[{"name": "Erdbeer"}, {"name": "Schokolade"}, {"name": "Vanille"}, {"name": "Saisonsorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE 'cba59bdc%';

/* 50. Milchbar Pinguin */
UPDATE shops SET flavor_list = '[{"name": "Erdbeer"}, {"name": "Schokolade"}, {"name": "Vanille"}, {"name": "Pistazie"}, {"name": "Eisbecher-Spezialitäten", "tag": "signatur"}, {"name": "Klassische Sorten"}]'::jsonb
WHERE id::text LIKE 'db823e46%';

/* 51. Eisdiele am See */
UPDATE shops SET flavor_list = '[{"name": "Schokolade-Chili", "tag": "signatur"}, {"name": "Schoko-Marzipan", "tag": "signatur"}, {"name": "Klassische Sorten"}, {"name": "Kreative Sorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE 'e5145fdb%';

/* 52. Mamalicious */
UPDATE shops SET flavor_list = '[{"name": "Vegane Sorten", "tag": "vegan"}, {"name": "Klassische Sorten"}]'::jsonb
WHERE id::text LIKE 'f2a521f6%';

/* 53. likken */
UPDATE shops SET flavor_list = '[{"name": "Schwarze Kokosnuss", "tag": "signatur"}, {"name": "Omas Teigschüssel", "tag": "signatur"}, {"name": "Milchreis"}, {"name": "Kokos", "tag": "vegan"}, {"name": "Mango", "tag": "vegan"}, {"name": "Waldmeister"}, {"name": "Orange-Basilikum", "tag": "exotisch"}, {"name": "Karotte", "tag": "exotisch"}, {"name": "Ananas-Basilikum", "tag": "exotisch"}, {"name": "Schoko-Birne"}, {"name": "Stracciatella"}, {"name": "Vegane Sorbets", "tag": "sorbet"}]'::jsonb
WHERE id::text LIKE 'f3c5087a%';

/* 54. Eisdiele Pfeifer */
UPDATE shops SET flavor_list = '[{"name": "Erdbeer"}, {"name": "Schokolade"}, {"name": "Vanille"}, {"name": "Klassische Sorten"}, {"name": "Saisonsorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE 'f68ed2d0%';

/* 55. Erikas Eiscafé Eutritzsch */
UPDATE shops SET flavor_list = '[{"name": "Rhabarber-Joghurt", "tag": "signatur"}, {"name": "Vanille Bacon", "tag": "exotisch"}, {"name": "Goldene Milch", "tag": "exotisch"}, {"name": "Rote Beete", "tag": "exotisch"}, {"name": "Kürbiskern", "tag": "saisonal"}, {"name": "Lakritz"}, {"name": "Schmand"}, {"name": "Schokolade-Sorbet", "tag": "sorbet"}, {"name": "SÜSSKIND-Wechselsorten", "tag": "saisonal"}]'::jsonb
WHERE id::text LIKE 'f9cc49b2%';

/* Drop signature_flavors column — data now lives in flavor_list with tags */
ALTER TABLE shops DROP COLUMN signature_flavors;
