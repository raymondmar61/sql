#https://www.w3resource.com/sql-exercises/soccer-database-exercise/index.php
#https://www.w3resource.com/w3r_images/soccer-database.png
#The sample database represents some of the data storage and retrieval about a soccer tournament based on EURO CUP 2016.
/*
#soccer_country
country_id	country_abbr	country_name
1201	ALB	Albania
1202	AUT	Austria
1203	BEL	Belgium
1204	CRO	Croatia
1205	CZE	Czech Republic
1206	ENG	England
1207	FRA	France
1208	GER	Germany
1209	HUN	Hungary
1210	ISL	Iceland
1211	ITA	Italy
1212	NIR	Northern Ireland
1213	POL	Poland
1214	POR	Portugal
1215	IRL	Republic of Ireland
1216	ROU	Romania
1217	RUS	Russia
1218	SVK	Slovakia
1219	ESP	Spain
1220	SWE	Sweden
1221	SUI	Switzerland
1222	TUR	Turkey
1223	UKR	Ukraine
1224	WAL	Wales
1225	SLO	Slovenia
1226	NED	Netherlands
1227	SRB	Serbia
1228	SCO	Scotland
1229	NOR	Norway

#soccer_city
city_id	city	country_id
10001	Paris	1207
10002	Saint-Denis	1207
10003	Bordeaux	1207
10004	Lens	1207
10005	Lille	1207
10006	Lyon	1207
10007	Marseille	1207
10008	Nice	1207
10009	Saint-Etienne	1207
10010	Toulouse	1207

#soccer_venue
venue_id	venue_name	city_id	aud_capacity
20001	Stade de Bordeaux	10003	42115
20002	Stade Bollaert-Delelis	10004	38223
20003	Stade Pierre Mauroy	10005	49822
20004	Stade de Lyon	10006	58585
20005	Stade VElodrome	10007	64354
20006	Stade de Nice	10008	35624
20007	Parc des Princes	10001	47294
20008	Stade de France	10002	80100
20009	Stade Geoffroy Guichard	10009	42000
20010	Stadium de Toulouse	10010	33150

#soccer_team
team_id	team_group	match_played	won	draw	lost	goal_for	goal_agnst	goal_diff	points	group_position
1201	A	3	1	0	2	1	3	-2	3	3
1202	F	3	0	1	2	1	4	-3	1	4
1203	E	3	2	0	1	4	2	2	6	2
1204	D	3	2	1	0	5	3	2	7	1
1205	D	3	0	1	2	2	5	-3	1	4
1206	B	3	1	2	0	3	2	1	5	2
1207	A	3	2	1	0	4	1	3	7	1
1208	C	3	2	1	0	3	0	3	7	1
1209	F	3	1	2	0	6	4	2	5	1
1210	F	3	1	2	0	4	3	1	5	2
1211	E	3	2	0	1	3	1	2	6	1
1212	C	3	1	0	2	2	2	0	3	3
1213	C	3	2	1	0	2	0	2	7	2
1214	F	3	0	3	0	4	4	0	3	3
1215	E	3	1	1	1	2	4	-2	4	3
1216	A	3	0	1	2	2	4	-2	1	4
1217	B	3	0	1	2	2	6	-4	1	4
1218	B	3	1	1	1	3	3	0	4	3
1219	D	3	2	0	1	5	2	3	6	2
1220	E	3	0	1	2	1	3	-2	1	4
1221	A	3	1	2	0	2	1	1	5	2
1222	D	3	1	0	2	2	4	-2	3	3
1223	C	3	0	0	3	0	5	-5	0	4
1224	B	3	2	0	1	6	3	3	6	1

#playing_position
position_id	position_desc
GK	Goalkeepers
DF	Defenders
MF	Midfielders
FD	Defenders

#player_mast
player_id	team_id	jersey_no	player_name	posi_to_play	dt_of_bir	age	playing_club
160001	1201	1	Etrit Berisha	GK	1989-03-10	27	Lazio
160008	1201	2	Andi Lila	DF	1986-02-12	30	Giannina
160016	1201	3	Ermir Lenjani	MF	1989-08-05	26	Nantes
160007	1201	4	Elseid Hysaj	DF	1994-02-20	22	Napoli
160013	1201	5	Lorik Cana	MF	1983-07-27	32	Nantes
160010	1201	6	Frederic Veseli	DF	1992-11-20	23	Lugano
160004	1201	7	Ansi Agolli	DF	1982-10-11	33	Qarabag
160012	1201	8	Migjen Basha	MF	1987-01-05	29	Como
160017	1201	9	Ledian Memushaj	MF	1986-12-17	29	Pescara
160023	1201	10	Armando Sadiku	FD	1991-05-27	25	Vaduz
160022	1201	11	Shkelzen Gashi	FD	1988-07-15	27	Colorado
160003	1201	12	Orges Shehi	GK	1977-09-25	38	Skenderbeu
160015	1201	13	Burim Kukeli	MF	1984-01-16	32	Zurich
160019	1201	14	Taulant Xhaka	MF	1991-03-28	25	Basel
160009	1201	15	Mergim Mavraj	DF	1986-06-09	30	Koln
160021	1201	16	Sokol Cikalleshi	FD	1990-07-27	25	Istanbul Basaksehir
160006	1201	17	Naser Aliji	DF	1993-12-27	22	Basel
160005	1201	18	Arlind Ajeti	DF	1993-09-25	22	Frosinone
160020	1201	19	Bekim Balaj	FD	1991-01-11	25	Rijeka
160014	1201	20	Ergys Kace	MF	1993-07-08	22	PAOK
160018	1201	21	Odise Roshi	MF	1991-05-22	25	Rijeka
160011	1201	22	Amir Abrashi	MF	1990-03-27	26	Freiburg
160002	1201	23	Alban Hoxha	GK	1987-11-23	28	Partizani
160024	1202	1	Robert Almer	GK	1984-03-20	32	Austria Wien
160036	1202	2	Gyorgy Garics	MF	1984-03-08	32	Darmstadt
160027	1202	3	Aleksandar Dragovic	DF	1991-03-06	25	Dynamo Kyiv
160029	1202	4	Martin Hinteregger	DF	1992-09-07	23	Monchengladbach
160028	1202	5	Christian Fuchs	DF	1986-04-07	30	Leicester
160038	1202	6	Stefan Ilsanker	MF	1989-05-18	27	Leipzig
160043	1202	7	Marko Arnautovic	FD	1989-04-19	27	Stoke
160034	1202	8	David Alaba	MF	1992-06-24	23	Bayern
160046	1202	9	Rubin Okotie	FD	1987-06-06	29	1860 Munchen
160040	1202	10	Zlatko Junuzovic	MF	1987-09-26	28	Bremen
160037	1202	11	Martin Harnik	MF	1987-06-10	29	Stuttgart
160025	1202	12	Heinz Lindner	GK	1990-07-17	25	Frankfurt
160032	1202	13	Markus Suttner	DF	1987-04-16	29	Ingolstadt
160035	1202	14	Julian Baumgartlinger	MF	1988-01-02	28	Mainz
160031	1202	15	Sebastian Prodl	DF	1987-06-21	28	Watford
160033	1202	16	Kevin Wimmer	DF	1992-11-15	23	Tottenham
160030	1202	17	Florian Klein	DF	1986-11-17	29	Stuttgart
160042	1202	18	Alessandro Schopf	MF	1994-02-07	22	Schalke
160044	1202	19	Lukas Hinterseer	FD	1991-03-28	25	Ingolstadt
160041	1202	20	Marcel Sabitzer	MF	1994-03-17	22	Leipzig
160045	1202	21	Marc Janko	FD	1983-06-25	32	Basel
160039	1202	22	Jakob Jantscher	MF	1989-01-08	27	Luzern
160026	1202	23	Ramazan Ozcan	GK	1984-06-28	31	Ingolstadt
160047	1203	1	Thibaut Courtois	GK	1992-05-11	24	Chelsea
160050	1203	2	Toby Alderweireld	DF	1989-03-02	27	Tottenham
160056	1203	3	Thomas Vermaelen	DF	1985-11-14	30	Barcelona
160063	1203	4	Radja Nainggolan	MF	1988-05-04	28	Roma
160057	1203	5	Jan Vertonghen	DF	1987-04-24	29	Tottenham
160064	1203	6	Axel Witsel	MF	1989-01-12	27	Zenit
160059	1203	7	Kevin De Bruyne	MF	1991-06-28	24	Man. City
160061	1203	8	Marouane Fellaini	MF	1987-11-22	28	Man. United
160067	1203	9	Romelu Lukaku	FD	1993-05-13	23	Everton
160062	1203	10	Eden Hazard	MF	1991-01-07	25	Chelsea
160058	1203	11	Yannick Carrasco	MF	1993-09-04	22	Atletico
160049	1203	12	Simon Mignolet	GK	1988-08-06	27	Liverpool
160048	1203	13	Jean-Francois Gillet	GK	1979-05-31	37	Mechelen
160068	1203	14	Dries Mertens	FD	1987-05-06	29	Napoli
160052	1203	15	Jason Denayer	DF	1995-06-28	20	Galatasaray
160055	1203	16	Thomas Meunier	DF	1991-09-12	24	Club Brugge
160069	1203	17	Divock Origi	FD	1995-04-18	21	Liverpool
160053	1203	18	Christian Kabasele	DF	1991-02-24	25	Genk
160060	1203	19	Mousa Dembele	MF	1987-07-16	28	Tottenham
160066	1203	20	Christian Benteke	FD	1990-12-03	25	Liverpool
160054	1203	21	Jordan Lukaku	DF	1994-07-25	21	Oostende
160065	1203	22	Michy Batshuayi	FD	1993-10-02	22	Marseille
160051	1203	23	Laurent Ciman	DF	1985-08-05	30	Montreal
160072	1204	1	Ivan Vargic	GK	1987-03-15	29	Rijeka
160079	1204	2	Sime Vrsaljko	DF	1992-01-10	24	Sassuolo
160077	1204	3	Ivan Strinic	DF	1987-07-17	28	Napoli
160085	1204	4	Ivan PeriSic	MF	1989-02-02	27	Internazionale
160073	1204	5	Vedran Corluka	DF	1986-02-05	30	Lokomotiv Moskva
160074	1204	6	Tin Jedvaj	DF	1995-11-28	20	Leverkusen
160086	1204	7	Ivan Rakitic	MF	1988-03-10	28	Barcelona
160083	1204	8	Mateo Kovacic	MF	1994-05-06	22	Real Madrid
160090	1204	9	Andrej Kramaric	FD	1991-06-19	24	Hoffenheim
160084	1204	10	Luka Modric	MF	1985-09-09	30	Real Madrid
160076	1204	11	Darijo Srna	DF	1982-05-01	34	Shakhtar Donetsk
160070	1204	12	Lovre Kalinic	GK	1990-04-03	26	Hajduk Split
160075	1204	13	Gordon Schildenfeld	DF	1985-03-18	31	Dinamo Zagreb
160081	1204	14	Marcelo Brozovic	MF	1992-11-16	23	Internazionale
160087	1204	15	Marko Rog	MF	1995-07-19	20	Dinamo Zagreb
160089	1204	16	Nikola Kalinic	FD	1988-01-05	28	Fiorentina
160091	1204	17	Mario Mandzukic	FD	1986-05-21	30	Juventus
160082	1204	18	Ante Coric	MF	1997-04-14	19	Dinamo Zagreb
160080	1204	19	Milan Badelj	MF	1989-02-25	27	Fiorentina
160092	1204	20	Marko Pjaca	FD	1995-05-06	21	Dinamo Zagreb
160078	1204	21	Domagoj Vida	DF	1989-04-29	27	Dynamo Kyiv
160088	1204	22	Duje Cop	FD	1990-02-01	26	Malaga
160071	1204	23	Danijel SubaSic	GK	1984-10-27	31	Monaco
160093	1205	1	Petr Cech	GK	1982-05-20	34	Arsenal
160098	1205	2	Pavel Kaderabek	DF	1992-04-25	24	Hoffenheim
160099	1205	3	Michal Kadlec	DF	1984-12-13	31	Fenerbahce
160096	1205	4	Theodor Gebre Selassie	DF	1986-12-24	29	Bremen
160097	1205	5	Roman Hubnik	DF	1984-06-06	32	Plzen
160101	1205	6	TomasSivok	DF	1983-09-15	32	Bursaspor
160114	1205	7	TomasNecid	FD	1989-08-13	26	Bursaspor
160100	1205	8	David Limbersky	DF	1983-10-06	32	Plzen
160104	1205	9	Borek Dockal	MF	1988-09-30	27	Sparta Praha
160110	1205	10	TomasRosicky	MF	1980-10-04	35	Arsenal
160109	1205	11	Daniel Pudil	MF	1985-09-27	30	Sheff. Wednesday
160115	1205	12	Milan Skoda	FD	1986-01-16	30	Slavia Praha
160108	1205	13	Jaroslav PlaSil	MF	1982-01-05	34	Bordeaux
160105	1205	14	Daniel Kolar	MF	1985-10-27	30	Plzen
160107	1205	15	David Pavelka	MF	1991-05-18	25	Kasimpasa
160095	1205	16	TomasVaclik	GK	1989-03-29	27	Basel
160102	1205	17	Marek Suchy	DF	1988-03-29	28	Basel
160112	1205	18	Josef Sural	MF	1990-05-30	26	Sparta Praha
160106	1205	19	Ladislav Krejci	MF	1992-07-05	23	Sparta Praha
160111	1205	20	Jiri Skalak	MF	1992-03-12	24	Brighton
160113	1205	21	David Lafata	FD	1981-09-18	34	Sparta Praha
160103	1205	22	Vladimir Darida	MF	1990-08-08	25	Hertha
160094	1205	23	TomasKoubek	GK	1992-08-26	23	Liberec
160117	1206	1	Joe Hart	GK	1987-04-19	29	Man. City
160125	1206	2	Kyle Walker	DF	1990-05-28	26	Tottenham
160122	1206	3	Danny Rose	DF	1990-07-02	25	Tottenham
160131	1206	4	James Milner	MF	1986-01-04	30	Liverpool
160120	1206	5	Gary Cahill	DF	1985-12-19	30	Chelsea
160123	1206	6	Chris Smalling	DF	1989-11-22	26	Man. United
160132	1206	7	Raheem Sterling	MF	1994-12-08	21	Man. City
160130	1206	8	Adam Lallana	MF	1988-05-10	28	Liverpool
160134	1206	9	Harry Kane	FD	1993-07-28	22	Tottenham
160136	1206	10	Wayne Rooney	FD	1985-10-24	30	Man. United
160138	1206	11	Jamie Vardy	FD	1987-01-11	29	Leicester
160121	1206	12	Nathaniel Clyne	DF	1991-04-05	25	Liverpool
160116	1206	13	Fraser Forster	GK	1988-03-17	28	Southampton
160129	1206	14	Jordan Henderson	MF	1990-06-17	26	Liverpool
160137	1206	15	Daniel Sturridge	FD	1989-09-01	26	Liverpool
160124	1206	16	John Stones	DF	1994-05-28	22	Everton
160128	1206	17	Eric Dier	MF	1994-01-15	22	Tottenham
160133	1206	18	Jack Wilshere	MF	1992-01-01	24	Arsenal
160127	1206	19	Ross Barkley	MF	1993-12-05	22	Everton
160126	1206	20	Dele Alli	MF	1996-04-11	20	Tottenham
160119	1206	21	Ryan Bertrand	DF	1989-08-05	26	Southampton
160135	1206	22	Marcus Rashford	FD	1997-10-31	18	Man. United
160118	1206	23	Tom Heaton	GK	1986-04-15	30	Burnley
160140	1207	1	Hugo Lloris	GK	1986-12-26	29	Tottenham
160144	1207	2	Christophe Jallet	DF	1983-10-31	32	Lyon
160143	1207	3	Patrice Evra	DF	1981-05-15	35	Juventus
160147	1207	4	Adil Rami	DF	1985-12-27	30	Sevilla
160152	1207	5	NGolo Kante	MF	1991-03-29	25	Leicester
160150	1207	6	Yohan Cabaye	MF	1986-01-14	30	Crystal Palace
160160	1207	7	Antoine Griezmann	FD	1991-03-21	25	Atletico
160154	1207	8	Dimitri Payet	MF	1987-03-29	29	West Ham
160159	1207	9	Olivier Giroud	FD	1986-09-30	29	Arsenal
160158	1207	10	Andre-Pierre Gignac	FD	1985-12-05	30	Tigres
160161	1207	11	Anthony Martial	FD	1995-12-05	20	Man. United
160156	1207	12	Morgan Schneiderlin	MF	1989-11-08	26	Man. United
160146	1207	13	Eliaquim Mangala	DF	1991-02-13	25	Man. City
160153	1207	14	Blaise Matuidi	MF	1987-04-09	29	Paris
160155	1207	15	Paul Pogba	MF	1993-03-15	23	Juventus
160141	1207	16	Steve Mandanda	GK	1985-03-28	31	Marseille
160142	1207	17	Lucas Digne	DF	1993-07-20	22	Roma
160157	1207	18	Moussa Sissoko	MF	1989-08-16	26	Newcastle
160148	1207	19	Bacary Sagna	DF	1983-02-14	33	Man. City
160151	1207	20	Kingsley Coman	MF	1996-06-13	20	Bayern
160145	1207	21	Laurent Koscielny	DF	1985-09-10	30	Arsenal
160149	1207	22	Samuel Umtiti	DF	1993-11-14	22	Lyon
160139	1207	23	Benoit Costil	GK	1987-07-03	28	Rennes
160163	1208	1	Manuel Neuer	GK	1986-03-27	30	Bayern
160170	1208	2	Shkodran Mustafi	DF	1992-04-17	24	Valencia
160166	1208	3	Jonas Hector	DF	1990-05-27	26	Koln
160167	1208	4	Benedikt Howedes	DF	1988-02-29	28	Schalke
160168	1208	5	Mats Hummels	DF	1988-12-16	27	Dortmund
160175	1208	6	Sami Khedira	MF	1987-04-04	29	Juventus
160180	1208	7	Bastian Schweinsteiger	MF	1984-08-01	31	Man. United
160177	1208	8	Mesut ozil	MF	1988-10-15	27	Arsenal
160179	1208	9	Andre Schurrle	MF	1990-11-06	25	Wolfsburg
160184	1208	10	Lukas Podolski	FD	1985-06-04	31	Galatasaray
160173	1208	11	Julian Draxler	MF	1993-09-20	22	Wolfsburg
160162	1208	12	Bernd Leno	GK	1992-03-04	24	Leverkusen
160183	1208	13	Thomas Muller	FD	1989-09-13	26	Bayern
160172	1208	14	Emre Can	MF	1994-01-12	22	Liverpool
160181	1208	15	Julian Weigl	MF	1995-09-08	20	Dortmund
160171	1208	16	Jonathan Tah	DF	1996-02-11	20	Leverkusen
160165	1208	17	Jerome Boateng	DF	1988-09-03	27	Bayern
160176	1208	18	Toni Kroos	MF	1990-01-04	26	Real Madrid
160174	1208	19	Mario Gotze	MF	1992-06-03	24	Bayern
160178	1208	20	Leroy Sane	MF	1996-01-11	20	Schalke
160169	1208	21	Joshua Kimmich	DF	1995-02-08	21	Bayern
160164	1208	22	Marc-Andre ter Stegen	GK	1992-04-30	24	Barcelona
160182	1208	23	Mario Gomez	FD	1985-07-10	30	Besiktas
160187	1209	1	Gabor Kiraly	GK	1976-04-01	40	Haladas
160194	1209	2	Adam Lang	DF	1993-01-17	23	Videoton
160193	1209	3	Mihaly Korhut	DF	1988-12-01	27	Debrecen
160192	1209	4	Tamas Kadar	DF	1990-03-14	26	Lech
160189	1209	5	Attila Fiola	DF	1990-02-17	26	Puskas Akademia
160196	1209	6	Akos Elek	MF	1988-07-21	27	Diosgyor
160202	1209	7	Balazs Dzsudzsak	FD	1986-12-23	29	Bursaspor
160199	1209	8	Adam Nagy	MF	1995-06-17	21	Ferencvaros
160207	1209	9	Adam Szalai	FD	1987-12-09	28	Hannover
160203	1209	10	Zoltan Gera	FD	1979-04-22	37	Ferencvaros
160204	1209	11	Krisztian Nemeth	FD	1989-01-05	27	Al-Gharafa
160185	1209	12	Denes Dibusz	GK	1990-11-16	25	Ferencvaros
160201	1209	13	Daniel Bode	FD	1986-10-24	29	Ferencvaros
160198	1209	14	Gergo Lovrencsics	MF	1988-09-01	27	Lech
160197	1209	15	Laszlo Kleinheisler	MF	1994-04-08	22	Bremen
160195	1209	16	adam Pinter	DF	1988-06-12	28	Ferencvaros
160205	1209	17	Nemanja Nikolic	FD	1987-12-31	28	Legia
160200	1209	18	Zoltan Stieber	MF	1988-10-16	27	Nurnberg
160206	1209	19	Tamas Priskin	FD	1986-09-27	29	Slovan Bratislava
160190	1209	20	Richard Guzmics	DF	1987-04-16	29	Wisla
160188	1209	21	Barnabas Bese	DF	1994-05-06	22	MTK
160186	1209	22	Peter Gulacsi	GK	1990-05-06	26	Leipzig
160191	1209	23	Roland Juhasz	DF	1983-07-01	32	Videoton
160208	1210	1	Hannes Halldorsson	GK	1984-04-27	32	Bodo/Glimt
160216	1210	2	Birkir Saevarsson	DF	1984-11-11	31	Hammarby
160212	1210	3	Haukur Heidar Hauksson	DF	1991-09-01	24	AIK
160213	1210	4	Hjortur Hermannsson	DF	1995-02-08	21	Goteborg
160214	1210	5	Sverrir Ingason	DF	1993-08-05	22	Lokeren
160217	1210	6	Ragnar Sigurdsson	DF	1986-06-19	29	Krasnodar
160229	1210	7	Johann Gudmundsson	FD	1990-10-27	25	Charlton
160221	1210	8	Birkir Bjarnason	MF	1988-05-27	28	Basel
160230	1210	9	Kolbeinn Sigthorsson	FD	1990-03-14	26	Nantes
160224	1210	10	Gylfi Sigurdsson	MF	1989-09-08	26	Swansea
160227	1210	11	Alfred Finnbogason	FD	1989-02-01	27	Augsburg
160210	1210	12	Ogmundur Kristinsson	GK	1989-06-19	26	Hammarby
160209	1210	13	Ingvar Jonsson	GK	1989-10-18	26	Sandefjord
160220	1210	14	Kari Arnason	MF	1982-10-13	33	Malmo
160226	1210	15	Jon Dadi Bodvarsson	FD	1992-05-25	24	Kaiserslautern
160225	1210	16	Runar Mar Sigurjonsson	MF	1990-06-18	26	Sundsvall
160222	1210	17	Aron Gunnarsson	MF	1989-04-22	27	Cardiff
160211	1210	18	Elmar Bjarnason	DF	1987-03-04	29	AGF
160215	1210	19	Hordur Magnusson	DF	1993-02-11	23	Cesena
160223	1210	20	Emil Hallfredsson	MF	1984-06-29	31	Udinese
160219	1210	21	Arnor Ingvi Traustason	DF	1993-04-30	23	Norrkoping
160228	1210	22	Eidur Gudjohnsen	FD	1978-09-15	37	Molde
160218	1210	23	Ari Skulason	DF	1987-05-14	29	OB
160231	1211	1	Gianluigi Buffon	GK	1978-01-28	38	Juventus
160238	1211	2	Mattia De Sciglio	DF	1992-10-20	23	Milan
160236	1211	3	Giorgio Chiellini	DF	1984-08-14	31	Juventus
160237	1211	4	Matteo Darmian	DF	1989-12-02	26	Man. United
160239	1211	5	Angelo Ogbonna	DF	1988-05-23	28	West Ham
160241	1211	6	Antonio Candreva	MF	1987-02-28	29	Lazio
160253	1211	7	Simone Zaza	FD	1991-06-25	24	Juventus
160243	1211	8	Alessandro Florenzi	MF	1991-03-11	25	Roma
160252	1211	9	Graziano Pelle	FD	1985-07-15	30	Southampton
160245	1211	10	Thiago Motta	MF	1982-08-28	33	Paris
160250	1211	11	Ciro Immobile	FD	1990-02-20	26	Torino
160233	1211	12	Salvatore Sirigu	GK	1987-01-12	29	Paris
160232	1211	13	Federico Marchetti	GK	1983-02-07	33	Lazio
160247	1211	14	Stefano Sturaro	MF	1993-03-09	23	Juventus
160234	1211	15	Andrea Barzagli	DF	1981-05-08	35	Juventus
160242	1211	16	Daniele De Rossi	MF	1983-07-24	32	Roma
160248	1211	17	Eder	FD	1986-11-15	29	Internazionale
160246	1211	18	Marco Parolo	MF	1985-01-25	31	Lazio
160235	1211	19	Leonardo Bonucci	DF	1987-05-01	29	Juventus
160251	1211	20	Lorenzo Insigne	FD	1991-06-04	25	Napoli
160240	1211	21	Federico Bernardeschi	MF	1994-02-16	22	Fiorentina
160249	1211	22	Stephan El Shaarawy	FD	1992-10-27	23	Roma
160244	1211	23	Emanuele Giaccherini	MF	1985-05-05	31	Bologna
160256	1212	1	Michael McGovern	GK	1984-07-12	31	Hamilton
160264	1212	2	Conor McLaughlin	DF	1991-07-26	24	Fleetwood
160269	1212	3	Shane Ferguson	MF	1991-07-12	24	Millwall
160262	1212	4	Gareth McAuley	DF	1979-12-05	36	West Brom
160259	1212	5	Jonny Evans	DF	1988-01-03	28	West Brom
160257	1212	6	Chris Baird	DF	1982-02-25	34	Fulham
160275	1212	7	Niall McGinn	FD	1987-07-20	28	Aberdeen
160267	1212	8	Steven Davis	MF	1985-01-01	31	Southampton
160273	1212	9	Will Grigg	FD	1991-07-03	24	Wigan
160274	1212	10	Kyle Lafferty	FD	1987-09-16	28	Birmingham
160276	1212	11	Conor Washington	FD	1992-05-18	24	QPR
160254	1212	12	Roy Carroll	GK	1977-09-30	38	Notts County
160268	1212	13	Corry Evans	MF	1990-07-30	25	Blackburn
160266	1212	14	Stuart Dallas	MF	1991-04-19	25	Leeds
160263	1212	15	Luke McCullough	DF	1994-02-15	22	Doncaster
160271	1212	16	Oliver Norwood	MF	1991-04-12	25	Reading
160265	1212	17	Paddy McNair	DF	1995-04-27	21	Man. United
160261	1212	18	Aaron Hughes	DF	1979-11-08	36	Melbourne City
160272	1212	19	Jamie Ward	MF	1986-05-12	30	Nottm Forest
160258	1212	20	Craig Cathcart	DF	1989-02-06	27	Watford
160270	1212	21	Josh Magennis	MF	1990-08-15	25	Kilmarnock
160260	1212	22	Lee Hodson	DF	1991-10-02	24	MK Dons
160255	1212	23	Alan Mannus	GK	1982-05-19	34	St Johnstone
160279	1213	1	Wojciech Szczesny	GK	1990-04-18	26	Roma
160283	1213	2	Michal Pazdan	DF	1987-09-21	28	Legia
160282	1213	3	Artur Jedrzejczyk	DF	1987-11-04	28	Legia
160280	1213	4	Thiago Cionek	DF	1986-04-21	30	Palermo
160293	1213	5	Krzysztof Maczynski	MF	1987-05-23	29	Wisla
160289	1213	6	Tomasz Jodlowiec	MF	1985-09-08	30	Legia
160298	1213	7	Arkadiusz Milik	FD	1994-02-28	22	Ajax
160292	1213	8	Karol Linetty	MF	1995-02-02	21	Lech
160297	1213	9	Robert Lewandowski	FD	1988-08-21	27	Bayern
160291	1213	10	Grzegorz Krychowiak	MF	1990-01-29	26	Sevilla
160288	1213	11	Kamil Grosicki	MF	1988-06-08	28	Rennes
160277	1213	12	Artur Boruc	GK	1980-02-20	36	Bournemouth
160299	1213	13	Mariusz Stepinski	FD	1995-05-12	21	Ruch
160286	1213	14	Jakub Wawrzyniak	DF	1983-07-07	32	Lechia
160281	1213	15	Kamil Glik	DF	1988-02-03	28	Torino
160287	1213	16	Jakub Blaszczykowski	MF	1985-12-14	30	Fiorentina
160294	1213	17	Slawomir Peszko	MF	1985-02-19	31	Lechia
160285	1213	18	Bartosz Salamon	DF	1991-05-01	25	Cagliari
160296	1213	19	Piotr Zielinski	MF	1994-05-20	22	Empoli
160284	1213	20	Lukasz Piszczek	DF	1985-06-03	31	Dortmund
160290	1213	21	Bartosz Kapustka	MF	1996-12-23	19	
160278	1213	22	Lukasz Fabianski	GK	1985-04-18	31	Swansea
160295	1213	23	Filip Starzynski	MF	1991-05-27	25	Zaglebie
160302	1214	1	Rui Patricio	GK	1988-02-15	28	Sporting CP
160303	1214	2	Bruno Alves	DF	1981-11-27	34	Fenerbahce
160307	1214	3	Pepe	DF	1983-02-26	33	Real Madrid
160306	1214	4	Jose Fonte	DF	1983-12-22	32	Southampton
160308	1214	5	Raphael Guerreiro	DF	1993-12-22	22	Lorient
160309	1214	6	Ricardo Carvalho	DF	1978-05-18	38	Monaco
160322	1214	7	Cristiano Ronaldo	FD	1985-02-05	31	Real Madrid
160314	1214	8	Joao Moutinho	MF	1986-09-08	29	Monaco
160319	1214	9	Eder	FD	1987-12-22	28	LOSC
160313	1214	10	Joao Mario	MF	1993-01-19	23	Sporting CP
160317	1214	11	Vieirinha	MF	1986-01-24	30	Wolfsburg
160301	1214	12	Anthony Lopes	GK	1990-10-01	25	Lyon
160312	1214	13	Danilo	MF	1991-09-09	24	Porto
160318	1214	14	William Carvalho	MF	1992-04-07	24	Sporting CP
160311	1214	15	Andre Gomes	MF	1993-07-30	22	Valencia
160316	1214	16	Renato Sanches	MF	1997-08-18	18	Benfica
160320	1214	17	Nani	FD	1986-11-17	29	Fenerbahce
160315	1214	18	Rafa Silva	MF	1993-05-17	23	Braga
160305	1214	19	Eliseu	DF	1983-10-01	32	Benfica
160321	1214	20	Ricardo Quaresma	FD	1983-09-26	32	Besiktas
160304	1214	21	Cedric	DF	1991-08-31	24	Southampton
160300	1214	22	Eduardo	GK	1982-09-19	33	Dinamo Zagreb
160310	1214	23	Adrien Silva	MF	1989-03-15	27	Sporting CP
160325	1215	1	Keiren Westwood	GK	1984-10-23	31	Sheff. Wednesday
160328	1215	2	Seamus Coleman	DF	1988-10-11	27	Everton
160327	1215	3	Ciaran Clark	DF	1989-09-26	26	Aston Villa
160331	1215	4	John OShea	DF	1981-04-30	35	Sunderland
160330	1215	5	Richard Keogh	DF	1986-08-11	29	Derby
160341	1215	6	Glenn Whelan	MF	1984-01-13	32	Stoke
160338	1215	7	Aiden McGeady	MF	1986-04-04	30	Sheff. Wednesday
160336	1215	8	James McCarthy	MF	1990-11-12	25	Everton
160343	1215	9	Shane Long	FD	1987-01-22	29	Southampton
160342	1215	10	Robbie Keane	FD	1980-07-08	35	LA Galaxy
160337	1215	11	James McClean	MF	1989-04-22	27	West Brom
160329	1215	12	Shane Duffy	DF	1992-01-01	24	Blackburn
160334	1215	13	Jeff Hendrick	MF	1992-01-31	24	Derby
160345	1215	14	Jon Walters	FD	1983-09-20	32	Stoke
160326	1215	15	Cyrus Christie	DF	1992-09-30	23	Derby
160323	1215	16	Shay Given	GK	1976-04-20	40	Stoke
160332	1215	17	Stephen Ward	DF	1985-08-20	30	Burnley
160339	1215	18	David Meyler	MF	1989-05-29	27	Hull
160333	1215	19	Robbie Brady	MF	1992-01-14	24	Norwich
160335	1215	20	Wes Hoolahan	MF	1982-05-20	34	Norwich
160344	1215	21	Daryl Murphy	FD	1983-03-15	33	Ipswich
160340	1215	22	Stephen Quinn	MF	1986-04-01	30	Reading
160324	1215	23	Darren Randolph	GK	1987-05-12	29	West Ham
160347	1216	1	Costel Pantilimon	GK	1987-02-01	29	Watford
160353	1216	2	Alexandru Matel	DF	1989-10-17	26	Dinamo Zagreb
160355	1216	3	Razvan Rat	DF	1981-05-26	35	Rayo Vallecano
160354	1216	4	Cosmin Moti	DF	1984-12-03	31	Ludogorets
160358	1216	5	Ovidiu Hoban	MF	1982-12-27	33	H. Beer-Sheva
160349	1216	6	Vlad Chiriches	DF	1989-11-14	26	Napoli
160357	1216	7	Alexandru Chipciu	MF	1989-05-18	27	Steaua
160359	1216	8	Mihai Pintilii	MF	1984-11-09	31	Steaua
160365	1216	9	Denis Alibec	FD	1991-01-05	25	Astra
160363	1216	10	Nicolae Stanciu	MF	1993-05-07	23	Steaua
160364	1216	11	Gabriel Torje	MF	1989-11-22	26	Osmanlispor
160348	1216	12	Ciprian Tatarusanu	GK	1986-02-09	30	Fiorentina
160367	1216	13	Claudiu Keeru	FD	1986-12-02	29	Ludogorets
160366	1216	14	Florin Andone	FD	1993-04-11	23	Cordoba
160351	1216	15	Valerica Gaman	DF	1989-02-25	27	Astra
160350	1216	16	Steliano Filip	DF	1994-05-15	22	Dinamo Bucuresti
160362	1216	17	Lucian Sanmartean	MF	1980-03-13	36	Al-Ittihad
160361	1216	18	Andrei Prepelita	MF	1985-12-08	30	Ludogorets
160368	1216	19	Bogdan Stancu	FD	1987-06-28	28	Genclerbirligi
160360	1216	20	Adrian Popa	MF	1988-07-24	27	Steaua
160352	1216	21	Dragos Grigore	DF	1986-09-07	29	Al-Sailiya
160356	1216	22	Cristian Sapunaru	DF	1984-04-05	32	Pandurii
160346	1216	23	Silviu Lung	GK	1989-06-04	27	Astra
160369	1217	1	Igor Akinfeev	GK	1986-04-08	30	CSKA Moskva
160378	1217	2	Roman Shishkin	DF	1987-01-27	29	Lokomotiv Moskva
160379	1217	3	Igor Smolnikov	DF	1988-08-08	27	Zenit
160374	1217	4	Sergei Ignashevich	DF	1979-07-14	36	CSKA Moskva
160376	1217	5	Roman Neustadter	DF	1988-02-18	28	Schalke
160372	1217	6	Aleksei Berezutski	DF	1982-06-20	33	CSKA Moskva
160388	1217	7	Artur Yusupov	MF	1989-09-01	26	Zenit
160380	1217	8	Denis Glushakov	MF	1987-01-27	29	Spartak Moskva
160390	1217	9	Aleksandr Kokorin	FD	1991-03-19	25	Zenit
160391	1217	10	Fedor Smolov	FD	1990-02-09	26	Krasnodar
160383	1217	11	Pavel Mamaev	MF	1988-09-17	27	Krasnodar
160371	1217	12	Yuri Lodygin	GK	1990-05-26	26	Zenit
160381	1217	13	Aleksandr Golovin	MF	1996-05-30	20	CSKA Moskva
160373	1217	14	Vasili Berezutski	DF	1982-06-20	33	CSKA Moskva
160386	1217	15	Roman Shirokov	MF	1981-07-06	34	CSKA Moskva
160370	1217	16	Guilherme	GK	1985-12-12	30	Lokomotiv Moskva
160385	1217	17	Oleg Shatov	MF	1990-07-29	25	Zenit
160382	1217	18	Oleg Ivanov	MF	1986-08-04	29	Terek
160384	1217	19	Aleksandr Samedov	MF	1984-07-19	31	Lokomotiv Moskva
160387	1217	20	Dmitri Torbinski	MF	1984-04-28	32	Krasnodar
160377	1217	21	Georgi Schennikov	DF	1991-04-27	25	CSKA Moskva
160389	1217	22	Artem Dzyuba	FD	1988-08-22	27	Zenit
160375	1217	23	Dmitri Kombarov	DF	1987-01-22	29	Spartak Moskva
160393	1218	1	Jan Mucha	GK	1982-12-05	33	Slovan Bratislava
160398	1218	2	Peter Pekarik	DF	1986-10-30	29	Hertha
160401	1218	3	Martin Skrtel	DF	1984-12-15	31	Liverpool
160395	1218	4	Jan Durica	DF	1981-12-10	34	Lokomotiv Moskva
160396	1218	5	Norbert Gyomber	DF	1992-07-03	23	Roma
160404	1218	6	Jan Gregus	MF	1991-01-29	25	Jablonec
160411	1218	7	Vladimir Weiss	MF	1989-11-30	26	Al-Gharafa
160403	1218	8	Ondrej Duda	MF	1994-12-05	21	Legia
160414	1218	9	Stanislav Sestak	FD	1982-12-16	33	Ferencvaros
160410	1218	10	Miroslav Stoch	MF	1989-10-19	26	Bursaspor
160413	1218	11	Adam Nemec	FD	1985-09-02	30	Willem II
160394	1218	12	Jan Novota	GK	1983-11-29	32	Rapid Wien
160406	1218	13	Patrik HroSovsky	MF	1992-04-22	24	Plzen
160400	1218	14	Milan Skriniar	DF	1995-02-11	21	Sampdoria
160397	1218	15	TomasHubocan	DF	1985-09-17	30	Dinamo Moskva
160399	1218	16	Kornel Salata	DF	1985-01-24	31	Slovan Bratislava
160405	1218	17	Marek Hamsik	MF	1987-07-27	28	Napoli
160402	1218	18	Dusan Svento	DF	1985-08-01	30	Koln
160407	1218	19	Juraj Kucka	MF	1987-02-26	29	Milan
160408	1218	20	Robert Mak	MF	1991-03-08	25	PAOK
160412	1218	21	Michal Duris	FD	1988-06-01	28	Plzen
160409	1218	22	Viktor Pecovsky	MF	1983-05-24	33	zilina
160392	1218	23	MatusKozacik	GK	1983-12-27	32	Plzen
160415	1219	1	Lker Casillas	GK	1981-05-20	35	Porto
160418	1219	2	Cesar Azpilicueta	DF	1989-08-28	26	Chelsea
160423	1219	3	Gerard Pique	DF	1987-02-02	29	Barcelona
160419	1219	4	Marc Bartra	DF	1991-01-15	25	Barcelona
160427	1219	5	Sergio Busquets	MF	1988-07-16	27	Barcelona
160429	1219	6	Andres Iniesta	MF	1984-05-11	32	Barcelona
160435	1219	7	Alvaro Morata	FD	1992-10-23	23	Juventus
160430	1219	8	Koke	MF	1992-01-08	24	Atletico
160434	1219	9	Lucas Vazquez	FD	1991-07-01	24	Real Madrid
160428	1219	10	Cesc Fabregas	MF	1987-05-04	29	Chelsea
160437	1219	11	Pedro Rodriguez	FD	1987-07-28	28	Chelsea
160420	1219	12	Hector Bellerin	DF	1995-03-19	21	Arsenal
160416	1219	13	David de Gea	GK	1990-11-07	25	Man. United
160432	1219	14	Thiago Alcantara	MF	1991-04-11	25	Bayern
160424	1219	15	Sergio Ramos	DF	1986-03-30	30	Real Madrid
160422	1219	16	Juanfran	DF	1985-01-09	31	Atletico
160425	1219	17	Mikel San Jose	DF	1989-05-30	27	Athletic
160421	1219	18	Jordi Alba	DF	1989-03-21	27	Barcelona
160426	1219	19	Bruno Soriano	MF	1984-06-12	32	Villarreal
160433	1219	20	Aritz Aduriz	FD	1981-02-11	35	Athletic
160431	1219	21	David Silva	MF	1986-01-08	30	Man. City
160436	1219	22	Nolito	FD	1986-10-15	29	Celta
160417	1219	23	Sergio Rico	GK	1993-09-01	22	Sevilla
160439	1220	1	Andreas Isaksson	GK	1981-10-03	34	Kasimpasa
160446	1220	2	Mikael Lustig	DF	1986-12-13	29	Celtic
160444	1220	3	Erik Johansson	DF	1988-12-30	27	Kobenhavn
160442	1220	4	Andreas Granqvist	DF	1985-04-16	31	Krasnodar
160447	1220	5	Martin Olsson	DF	1988-05-17	28	Norwich
160451	1220	6	Emil Forsberg	MF	1991-10-23	24	Leipzig
160454	1220	7	Sebastian Larsson	MF	1985-06-06	31	Sunderland
160449	1220	8	Albin Ekdal	MF	1989-07-28	26	Hamburg
160453	1220	9	Kim Kallstrom	MF	1982-08-24	33	Grasshoppers
160459	1220	10	Zlatan Ibrahimovic	FD	1981-10-03	34	Paris
160457	1220	11	Marcus Berg	FD	1986-08-17	29	Panathinaikos
160440	1220	12	Robin Olsen	GK	1990-01-08	26	Kobenhavn
160443	1220	13	Pontus Jansson	DF	1991-02-13	25	Torino
160445	1220	14	Victor Lindelof	DF	1994-07-17	21	Benfica
160452	1220	15	Oscar Hiljemark	MF	1992-06-28	23	Palermo
160456	1220	16	Pontus Wernbloom	MF	1986-06-25	29	CSKA Moskva
160441	1220	17	Ludwig Augustinsson	DF	1994-04-21	22	Kobenhavn
160455	1220	18	Oscar Lewicki	MF	1992-07-14	23	Malmo
160460	1220	19	Emir Kujovic	FD	1988-06-22	27	Norrkoping
160458	1220	20	John Guidetti	FD	1992-04-15	24	Celta
160448	1220	21	Jimmy Durmaz	MF	1989-03-22	27	Olympiacos
160450	1220	22	Erkan Zengin	MF	1985-08-05	30	Trabzonspor
160438	1220	23	Patrik Carlgren	GK	1992-01-08	24	AIK
160463	1221	1	Yann Sommer	GK	1988-12-17	27	Monchengladbach
160467	1221	2	Stephan Lichtsteiner	DF	1984-01-16	32	Juventus
160468	1221	3	Francois Moubandje	DF	1990-06-21	25	Toulouse
160465	1221	4	Nico Elvedi	DF	1996-09-30	19	Monchengladbach
160471	1221	5	Steve von Bergen	DF	1983-06-10	33	Young Boys
160466	1221	6	Michael Lang	DF	1991-02-08	25	Basel
160480	1221	7	Breel Embolo	FD	1997-02-14	19	Basel
160475	1221	8	Fabian Frei	MF	1989-01-08	27	Mainz
160482	1221	9	Haris Seferovic	FD	1992-02-22	24	Frankfurt
160477	1221	10	Granit Xhaka	MF	1992-09-27	23	Monchengladbach
160472	1221	11	Valon Behrami	MF	1985-04-19	31	Watford
160462	1221	12	Marwin Hitz	GK	1987-09-18	28	Augsburg
160469	1221	13	Ricardo Rodriguez	DF	1992-08-25	23	Wolfsburg
160478	1221	14	Denis Zakaria	MF	1996-11-20	19	Young Boys
160473	1221	15	Blerim Dzemaili	MF	1986-04-12	30	Genoa
160474	1221	16	Gelson Fernandes	MF	1986-09-02	29	Rennes
160483	1221	17	Shani Tarashaj	FD	1995-02-07	21	Grasshoppers
160481	1221	18	Admir Mehmedi	FD	1991-03-16	25	Leverkusen
160479	1221	19	Eren Derdiyok	FD	1988-06-12	28	Kasimpasa
160464	1221	20	Johan Djourou	DF	1987-01-18	29	Hamburg
160461	1221	21	Roman Burki	GK	1990-11-14	25	Dortmund
160470	1221	22	Fabian Schar	DF	1991-12-20	24	Hoffenheim
160476	1221	23	Xherdan Shaqiri	MF	1991-10-10	24	Stoke
160486	1222	1	Volkan Babacan	GK	1988-08-11	27	Istanbul Basaksehir
160492	1222	2	Semih Kaya	DF	1991-02-24	25	Galatasaray
160490	1222	3	Hakan Balta	DF	1983-03-23	33	Galatasaray
160487	1222	4	Ahmet Calik	DF	1994-02-26	22	Genclerbirligi
160497	1222	5	Nuri Sahin	MF	1988-09-05	27	Dortmund
160495	1222	6	Hakan Calhanoglu	MF	1994-02-08	22	Leverkusen
160489	1222	7	Gokhan Gonul	DF	1985-01-04	31	Fenerbahce
160501	1222	8	Selcuk Inan	MF	1985-02-10	31	Galatasaray
160505	1222	9	Cenk Tosun	FD	1991-06-07	25	Besiktas
160494	1222	10	Arda Turan	MF	1987-01-30	29	Barcelona
160499	1222	11	Olcay Sahan	MF	1987-05-26	29	Besiktas
160485	1222	12	Onur Kivrak	GK	1988-01-01	28	Trabzonspor
160491	1222	13	Ismail Koybasi	DF	1989-07-10	26	Besiktas
160498	1222	14	Oguzhan Ozyakup	MF	1992-09-23	23	Besiktas
160496	1222	15	Mehmet Topal	MF	1986-03-03	30	Fenerbahce
160500	1222	16	Ozan Tufan	MF	1995-03-23	21	Fenerbahce
160504	1222	17	Burak Yilmaz	FD	1985-07-15	30	Beijing Guoan
160488	1222	18	Caner Erkin	DF	1988-10-04	27	Fenerbahce
160503	1222	19	Yunus Malli	MF	1992-02-24	24	Mainz
160502	1222	20	Volkan Sen	MF	1987-07-07	28	Fenerbahce
160506	1222	21	Emre Mor	FD	1997-07-24	18	Nordsjælland
160493	1222	22	Sener Ozbayrakli	DF	1990-01-23	26	Fenerbahce
160484	1222	23	Harun Tekin	GK	1989-06-17	27	Bursaspor
160507	1223	1	Denys Boyko	GK	1988-01-29	28	Besiktas
160510	1223	2	Bohdan Butko	DF	1991-01-13	25	Amkar
160512	1223	3	Yevhen Khacheridi	DF	1987-07-28	28	Dynamo Kyiv
160524	1223	4	Anatoliy Tymoshchuk	MF	1979-03-30	37	Kairat
160513	1223	5	Olexandr Kucher	DF	1982-10-22	33	Shakhtar Donetsk
160522	1223	6	Taras Stepanenko	MF	1989-08-08	26	Shakhtar Donetsk
160525	1223	7	Andriy Yarmolenko	MF	1989-10-23	26	Dynamo Kyiv
160529	1223	8	Roman Zozulya	FD	1989-11-17	26	Dnipro
160519	1223	9	Viktor Kovalenko	MF	1996-02-14	20	Shakhtar Donetsk
160518	1223	10	Yevhen Konoplyanka	MF	1989-09-29	26	Sevilla
160528	1223	11	Yevhen Seleznyov	FD	1985-07-20	30	Shakhtar Donetsk
160508	1223	12	Andriy Pyatov	GK	1984-06-28	31	Shakhtar Donetsk
160515	1223	13	Vyacheslav Shevchuk	DF	1979-05-13	37	Shakhtar Donetsk
160520	1223	14	Ruslan Rotan	MF	1981-10-29	34	Dnipro
160527	1223	15	Pylyp Budkivskiy	FD	1992-03-10	24	Zorya
160523	1223	16	Serhiy Sydorchuk	MF	1991-05-02	25	Dynamo Kyiv
160511	1223	17	Artem Fedetskiy	DF	1985-04-26	31	Dnipro
160521	1223	18	Serhiy Rybalka	MF	1990-04-01	26	Dynamo Kyiv
160516	1223	19	Denys Garmash	MF	1990-04-19	26	Dynamo Kyiv
160514	1223	20	Yaroslav Rakitskiy	DF	1989-08-03	26	Shakhtar Donetsk
160526	1223	21	Olexandr Zinchenko	MF	1996-12-15	19	Ufa
160517	1223	22	Olexandr Karavaev	MF	1992-06-02	24	Zorya
160509	1223	23	Mykyta Shevchenko	GK	1993-01-26	23	Zorya
160531	1224	1	Wayne Hennessey	GK	1987-01-24	29	Crystal Palace
160536	1224	2	Chris Gunter	DF	1989-07-21	26	Reading
160538	1224	3	Neil Taylor	DF	1989-02-07	27	Swansea
160535	1224	4	Ben Davies	DF	1993-04-24	23	Tottenham
160533	1224	5	James Chester	DF	1989-01-23	27	West Brom
160539	1224	6	Ashley Williams	DF	1984-08-23	31	Swansea
160540	1224	7	Joe Allen	MF	1990-03-14	26	Liverpool
160542	1224	8	Andy King	MF	1988-10-29	27	Leicester
160550	1224	9	Hal Robson-Kanu	FD	1989-05-21	27	Reading
160544	1224	10	Aaron Ramsey	MF	1990-12-26	25	Arsenal
160547	1224	11	Gareth Bale	FD	1989-07-16	26	Real Madrid
160530	1224	12	Owain Fon Williams	GK	1987-03-17	29	Inverness
160552	1224	13	George Williams	FD	1995-09-07	20	Fulham
160541	1224	14	David Edwards	MF	1986-02-03	30	Wolves
160537	1224	15	Jazz Richards	DF	1991-04-12	25	Fulham
160543	1224	16	Joe Ledley	MF	1987-01-23	29	Crystal Palace
160549	1224	17	David Cotterill	FD	1987-12-04	28	Birmingham
160551	1224	18	Sam Vokes	FD	1989-10-21	26	Burnley
160534	1224	19	James Collins	DF	1983-08-23	32	West Ham
160546	1224	20	Jonathan Williams	MF	1993-10-09	22	Crystal Palace
160532	1224	21	Danny Ward	GK	1993-06-22	22	Liverpool
160545	1224	22	David Vaughan	MF	1983-02-18	33	Nottm Forest
160548	1224	23	Simon Church	FD	1988-12-10	27	MK Dons

#referee_mast
referee_id	referee_name	country_id
70001	Damir Skomina	1225
70002	Martin Atkinson	1206
70003	Felix Brych	1208
70004	Cuneyt Cakir	1222
70005	Mark Clattenburg	1206
70006	Jonas Eriksson	1220
70007	Viktor Kassai	1209
70008	Bjorn Kuipers	1226
70009	Szymon Marciniak	1213
70010	Milorad Mazic	1227
70011	Nicola Rizzoli	1211
70012	Carlos Velasco Carballo	1219
70013	William Collum	1228
70015	Sergei Karasev	1217
70016	Pavel Kralovec	1205
70017	Svein Oddvar Moen	1229
70018	Clement Turpin	1207
70014	Ovidiu Hategan	1216

#match_mast
match_no	play_stage	play_date	results	decided_by	goal_score	venue_id	referee_id	audence	plr_of_match	stop1_sec	stop2_sec
1	G	2016-06-11	WIN	N	2-1	20008	70007	75113	160154	131	242
2	G	2016-06-11	WIN	N	0-1	20002	70012	33805	160476	61	182
3	G	2016-06-11	WIN	N	2-1	20001	70017	37831	160540	64	268
4	G	2016-06-12	DRAW	N	1-1	20005	70011	62343	160128	0	185
5	G	2016-06-12	WIN	N	0-1	20007	70006	43842	160084	125	325
6	G	2016-06-12	WIN	N	1-0	20006	70014	33742	160291	2	246
7	G	2016-06-13	WIN	N	2-0	20003	70002	43035	160176	89	188
8	G	2016-06-13	WIN	N	1-0	20010	70009	29400	160429	360	182
9	G	2016-06-13	DRAW	N	1-1	20008	70010	73419	160335	67	194
10	G	2016-06-14	WIN	N	0-2	20004	70005	55408	160244	63	189
11	G	2016-06-14	WIN	N	0-2	20001	70018	34424	160197	61	305
12	G	2016-06-15	DRAW	N	1-1	20009	70004	38742	160320	15	284
13	G	2016-06-15	WIN	N	1-2	20003	70001	38989	160405	62	189
14	G	2016-06-15	DRAW	N	1-1	20007	70015	43576	160477	74	206
15	G	2016-06-16	WIN	N	2-0	20005	70013	63670	160154	71	374
16	G	2016-06-16	WIN	N	2-1	20002	70003	34033	160540	62	212
17	G	2016-06-16	WIN	N	0-2	20004	70016	51043	160262	7	411
18	G	2016-06-17	DRAW	N	0-0	20008	70008	73648	160165	6	208
19	G	2016-06-17	WIN	N	1-0	20010	70007	29600	160248	2	264
20	G	2016-06-17	DRAW	N	2-2	20009	70005	38376	160086	71	280
21	G	2016-06-18	WIN	N	3-0	20006	70010	33409	160429	84	120
22	G	2016-06-18	WIN	N	3-0	20001	70004	39493	160064	11	180
23	G	2016-06-18	DRAW	N	1-1	20005	70015	60842	160230	61	280
24	G	2016-06-19	DRAW	N	0-0	20007	70011	44291	160314	3	200
25	G	2016-06-20	WIN	N	0-1	20004	70016	49752	160005	125	328
26	G	2016-06-20	DRAW	N	0-0	20003	70001	45616	160463	60	122
27	G	2016-06-21	WIN	N	0-3	20010	70006	28840	160544	62	119
28	G	2016-06-21	DRAW	N	0-0	20009	70012	39051	160392	62	301
29	G	2016-06-21	WIN	N	0-1	20005	70017	58874	160520	29	244
30	G	2016-06-21	WIN	N	0-1	20007	70018	44125	160177	21	195
31	G	2016-06-22	WIN	N	0-2	20002	70013	32836	160504	60	300
32	G	2016-06-22	WIN	N	2-1	20001	70008	37245	160085	70	282
33	G	2016-06-22	WIN	N	2-1	20008	70009	68714	160220	7	244
34	G	2016-06-22	DRAW	N	3-3	20004	70002	55514	160322	70	185
35	G	2016-06-23	WIN	N	0-1	20003	70014	44268	160333	79	221
36	G	2016-06-23	WIN	N	0-1	20006	70003	34011	160062	63	195
37	R	2016-06-25	WIN	P	1-1	20009	70005	38842	160476	126	243
38	R	2016-06-25	WIN	N	1-0	20007	70002	44342	160547	5	245
39	R	2016-06-26	WIN	N	0-1	20002	70012	33523	160316	61	198
40	R	2016-06-26	WIN	N	2-1	20004	70011	56279	160160	238	203
41	R	2016-06-26	WIN	N	3-0	20003	70009	44312	160173	62	124
42	R	2016-06-27	WIN	N	0-4	20010	70010	28921	160062	3	133
43	R	2016-06-27	WIN	N	2-0	20008	70004	76165	160235	63	243
44	R	2016-06-28	WIN	N	1-2	20006	70001	33901	160217	5	199
45	Q	2016-07-01	WIN	P	1-1	20005	70003	62940	160316	58	181
46	Q	2016-07-02	WIN	N	3-1	20003	70001	45936	160550	14	182
47	Q	2016-07-03	WIN	P	1-1	20001	70007	38764	160163	63	181
48	Q	2016-07-04	WIN	N	5-2	20008	70008	76833	160159	16	125
49	S	2016-07-07	WIN	N	2-0	20004	70006	55679	160322	2	181
50	S	2016-07-08	WIN	N	2-0	20005	70011	64078	160160	126	275
51	F	2016-07-11	WIN	N	1-0	20008	70005	75868	160307	161	181

#coach_mast
coach_id	coach_name
5550	Gianni De Biasi
5551	Marcel Koller
5552	Marc Wilmots
5553	Ante Cacic
5554	Pavel Vrba
5555	Roy Hodgson
5556	Didier Deschamps
5557	Joachim Low
5558	Bernd Storck
5559	Lars Lagerback
5560	Heimir Hallgrímsson
5561	Antonio Conte
5562	Michael ONeill
5563	Adam Nawalka
5564	Fernando Santos
5565	Martin ONeill
5566	Anghel Iordanescu
5567	Leonid Slutski
5568	Jan Kozak
5569	Vicente del Bosque
5570	Erik Hamren
5571	Vladimir Petkovic
5572	Fatih Terim
5573	Mykhailo Fomenko
5574	Chris Coleman

#asst_referee_mast
ass_ref_id	ass_ref_name	country_id
80034	Tomas Mokrusch	1205
80038	Martin Wilczek	1205
80004	Simon Beck	1206
80006	Stephen Child	1206
80007	Jake Collin	1206
80014	Mike Mullarkey	1206
80026	Frederic Cano	1207
80028	Nicolas Danos	1207
80005	Mark Borsch	1208
80013	Stefan Lupp	1208
80016	Gyorgy Ring	1209
80020	Vencel Toth	1209
80033	Damien McGraith	1215
80008	Elenito Di Liberatore	1211
80019	Mauro Tonolini	1211
80021	Sander van Roekel	1226
80024	Erwin Zeinstra	1226
80025	Frank Andas	1229
80031	Kim Haglund	1229
80012	Tomasz Listkiewicz	1213
80018	Pawel Sokolnicki	1213
80029	Sebastian Gheorghe	1216
80036	Octavian Sovre	1216
80030	Nikolay Golubev	1217
80032	Tikhon Kalugin	1217
80037	Anton Averyanov	1217
80027	Frank Connor	1228
80010	Dalibor Durdevic	1227
80017	Milovan Ristic	1227
80035	Roman Slysko	1218
80001	Jure Praprotnik	1225
80002	Robert Vukan	1225
80003	Roberto Alonso Fernandez	1219
80023	Juan Yuste Jimenez	1219
80011	Mathias Klasenius	1220
80022	Daniel Warnmark	1220
80009	Bahattin Duran	1222
80015	Tarik Ongun	1222

#match_details
match_no	play_stage	team_id	win_lose	decided_by	goal_score	penalty_score	ass_ref	player_gk
1	G	1207	W	N	2		80016	160140
1	G	1216	L	N	1		80020	160348
2	G	1201	L	N	0		80003	160001
2	G	1221	W	N	1		80023	160463
3	G	1224	W	N	2		80031	160532
3	G	1218	L	N	1		80025	160392
4	G	1206	D	N	1		80008	160117
4	G	1217	D	N	1		80019	160369
5	G	1222	L	N	0		80011	160486
5	G	1204	W	N	1		80022	160071
6	G	1213	W	N	1		80036	160279
6	G	1212	L	N	0		80029	160256
7	G	1208	W	N	2		80014	160163
7	G	1223	L	N	0		80006	160508
8	G	1219	W	N	1		80018	160416
8	G	1205	L	N	0		80012	160093
9	G	1215	D	N	1		80017	160324
9	G	1220	D	N	1		80010	160439
10	G	1203	L	N	0		80004	160047
10	G	1211	W	N	2		80007	160231
11	G	1202	L	N	0		80026	160024
11	G	1209	W	N	2		80028	160187
12	G	1214	D	N	1		80009	160302
12	G	1210	D	N	1		80015	160208
13	G	1217	L	N	1		80001	160369
13	G	1218	W	N	2		80002	160392
14	G	1216	D	N	1		80030	160348
14	G	1221	D	N	1		80032	160463
15	G	1207	W	N	2		80033	160140
15	G	1201	L	N	0		80027	160001
16	G	1206	W	N	2		80005	160117
16	G	1224	L	N	1		80013	160531
17	G	1223	L	N	0		80035	160508
17	G	1212	W	N	2		80034	160256
18	G	1208	D	N	0		80021	160163
18	G	1213	D	N	0		80024	160278
19	G	1211	W	N	1		80016	160231
19	G	1220	L	N	0		80020	160439
20	G	1205	D	N	2		80004	160093
20	G	1204	D	N	2		80007	160071
21	G	1219	W	N	3		80017	160416
21	G	1222	L	N	0		80010	160486
22	G	1203	W	N	3		80009	160047
22	G	1215	L	N	0		80015	160324
23	G	1210	D	N	1		80030	160208
23	G	1209	D	N	1		80032	160187
24	G	1214	D	N	0		80008	160302
24	G	1202	D	N	0		80019	160024
25	G	1216	L	N	0		80035	160348
25	G	1201	W	N	1		80034	160001
26	G	1221	D	N	0		80001	160463
26	G	1207	D	N	0		80002	160140
27	G	1217	L	N	0		80011	160369
27	G	1224	W	N	3		80022	160531
28	G	1218	D	N	0		80003	160392
28	G	1206	D	N	0		80023	160117
29	G	1223	L	N	0		80031	160508
29	G	1213	W	N	1		80025	160278
30	G	1212	L	N	0		80026	160256
30	G	1208	W	N	1		80028	160163
31	G	1205	L	N	0		80033	160093
31	G	1222	W	N	2		80027	160486
32	G	1204	W	N	2		80021	160071
32	G	1219	L	N	1		80024	160416
33	G	1210	W	N	2		80018	160208
33	G	1202	L	N	1		80012	160024
34	G	1209	D	N	3		80014	160187
34	G	1214	D	N	3		80006	160302
35	G	1211	L	N	0		80036	160233
35	G	1215	W	N	1		80029	160324
36	G	1220	L	N	0		80005	160439
36	G	1203	W	N	1		80013	160047
37	R	1221	L	P	1	4	80004	160463
37	R	1213	W	P	1	5	80007	160278
38	R	1224	W	N	1		80014	160531
38	R	1212	L	N	0		80006	160256
39	R	1204	L	N	0		80003	160071
39	R	1214	W	N	1		80023	160302
40	R	1207	W	N	2		80008	160140
40	R	1215	L	N	1		80019	160324
41	R	1208	W	N	3		80018	160163
41	R	1218	L	N	0		80012	160392
42	R	1209	L	N	0		80017	160187
42	R	1203	W	N	4		80010	160047
43	R	1211	W	N	2		80009	160231
43	R	1219	L	N	0		80015	160416
44	R	1206	L	N	1		80001	160117
44	R	1210	W	N	2		80002	160208
45	Q	1213	L	P	1	3	80005	160278
45	Q	1214	W	P	1	5	80013	160302
46	Q	1224	W	N	3		80001	160531
46	Q	1203	L	N	1		80002	160047
47	Q	1208	W	P	1	6	80016	160163
47	Q	1211	L	P	1	5	80020	160231
48	Q	1207	W	N	5		80021	160140
48	Q	1210	L	N	2		80024	160208
49	S	1214	W	N	2		80011	160302
49	S	1224	L	N	0		80022	160531
50	S	1207	W	N	2		80008	160140
50	S	1208	L	N	1		80019	160163
51	F	1214	W	N	1		80004	160302
51	F	1207	L	N	0		80007	160140

#goal_details
goal_id	match_no	player_id	team_id	goal_time	goal_type	play_stage	goal_schedule	goal_half
1	1	160159	1207	57	N	G	NT	2
2	1	160368	1216	65	P	G	NT	2
3	1	160154	1207	89	N	G	NT	2
4	2	160470	1221	5	N	G	NT	1
5	3	160547	1224	10	N	G	NT	1
6	3	160403	1218	61	N	G	NT	2
7	3	160550	1224	81	N	G	NT	2
8	4	160128	1206	73	N	G	NT	2
9	4	160373	1217	93	N	G	ST	2
10	5	160084	1204	41	N	G	NT	1
11	6	160298	1213	51	N	G	NT	2
12	7	160183	1208	19	N	G	NT	1
13	7	160180	1208	93	N	G	ST	2
14	8	160423	1219	87	N	G	NT	2
15	9	160335	1215	48	N	G	NT	2
16	9	160327	1215	71	O	G	NT	2
17	10	160244	1211	32	N	G	NT	1
18	10	160252	1211	93	N	G	ST	2
19	11	160207	1209	62	N	G	NT	2
20	11	160200	1209	87	N	G	NT	2
21	12	160320	1214	31	N	G	NT	1
22	12	160221	1210	50	N	G	NT	2
23	13	160411	1218	32	N	G	NT	1
24	13	160405	1218	45	N	G	NT	1
25	13	160380	1217	80	N	G	NT	2
26	14	160368	1216	18	P	G	NT	1
27	14	160481	1221	57	N	G	NT	2
28	15	160160	1207	90	N	G	NT	2
29	15	160154	1207	96	N	G	ST	2
30	16	160547	1224	42	N	G	NT	1
31	16	160138	1206	56	N	G	NT	2
32	16	160137	1206	93	N	G	ST	2
33	17	160262	1212	49	N	G	NT	2
34	17	160275	1212	96	N	G	ST	2
35	19	160248	1211	88	N	G	NT	2
36	20	160085	1204	37	N	G	NT	1
37	20	160086	1204	59	N	G	NT	2
38	20	160115	1205	76	N	G	NT	2
39	20	160114	1205	89	P	G	NT	2
40	21	160435	1219	34	N	G	NT	1
41	21	160436	1219	37	N	G	NT	1
42	21	160435	1219	48	N	G	NT	2
43	22	160067	1203	48	N	G	NT	2
44	22	160064	1203	61	N	G	NT	2
45	22	160067	1203	70	N	G	NT	2
46	23	160224	1210	40	P	G	NT	1
47	23	160216	1210	88	O	G	NT	2
48	25	160023	1201	43	N	G	NT	1
49	27	160544	1224	11	N	G	NT	1
50	27	160538	1224	20	N	G	NT	1
51	27	160547	1224	67	N	G	NT	2
52	29	160287	1213	54	N	G	NT	2
53	30	160182	1208	30	N	G	NT	1
54	31	160504	1222	10	N	G	NT	1
55	31	160500	1222	65	N	G	NT	2
56	32	160435	1219	7	N	G	NT	1
57	32	160089	1204	45	N	G	NT	1
58	32	160085	1204	87	N	G	NT	2
59	33	160226	1210	18	N	G	NT	1
60	33	160042	1202	60	N	G	NT	2
61	33	160226	1210	94	N	G	ST	2
62	34	160203	1209	19	N	G	NT	1
63	34	160320	1214	42	N	G	NT	1
64	34	160202	1209	47	N	G	NT	2
65	34	160322	1214	50	N	G	NT	2
66	34	160202	1209	55	N	G	NT	2
67	34	160322	1214	62	N	G	NT	2
68	35	160333	1215	85	N	G	NT	2
69	36	160063	1203	84	N	G	NT	2
70	37	160287	1213	39	N	R	NT	1
71	37	160476	1221	82	N	R	NT	2
72	38	160262	1212	75	O	R	NT	2
73	39	160321	1214	117	N	R	ET	2
74	40	160333	1215	2	P	R	NT	1
75	40	160160	1207	58	N	R	NT	2
76	40	160160	1207	61	N	R	NT	2
77	41	160165	1208	8	N	R	NT	1
78	41	160182	1208	43	N	R	NT	1
79	41	160173	1208	63	N	R	NT	2
80	42	160050	1203	10	N	R	NT	1
81	42	160065	1203	78	N	R	NT	2
82	42	160062	1203	80	N	R	NT	2
83	42	160058	1203	90	N	R	NT	2
84	43	160236	1211	33	N	R	NT	1
85	43	160252	1211	91	N	R	ST	2
86	44	160136	1206	4	P	R	NT	1
87	44	160219	1210	6	N	R	NT	1
88	44	160230	1210	18	N	R	NT	1
89	45	160297	1213	2	N	Q	NT	1
90	45	160316	1214	33	N	Q	NT	1
91	46	160063	1203	13	N	Q	NT	1
92	46	160539	1224	31	N	Q	NT	1
93	46	160550	1224	55	N	Q	NT	2
94	46	160551	1224	86	N	Q	NT	2
95	47	160177	1208	65	N	Q	NT	2
96	47	160235	1211	78	P	Q	NT	2
97	48	160159	1207	12	N	Q	NT	1
98	48	160155	1207	20	N	Q	NT	1
99	48	160154	1207	43	N	Q	NT	1
100	48	160160	1207	45	N	Q	NT	1
101	48	160230	1210	56	N	Q	NT	2
102	48	160159	1207	59	N	Q	NT	2
103	48	160221	1210	84	N	Q	NT	2
104	49	160322	1214	50	N	S	NT	2
105	49	160320	1214	53	N	S	NT	2
106	50	160160	1207	47	P	S	ST	1
107	50	160160	1207	72	N	S	NT	2
108	51	160319	1214	109	N	F	ET	2

#penalty_shootout
kick_id	match_no	team_id	player_id	score_goal	kick_no
1	37	1221	160467	Y	1
2	37	1213	160297	Y	2
3	37	1221	160477	N	3
4	37	1213	160298	Y	4
5	37	1221	160476	Y	5
6	37	1213	160281	Y	6
7	37	1221	160470	Y	7
8	37	1213	160287	Y	8
9	37	1221	160469	Y	9
10	37	1213	160291	Y	10
11	45	1214	160322	Y	1
12	45	1213	160297	Y	2
13	45	1214	160316	Y	3
14	45	1213	160298	Y	4
15	45	1214	160314	Y	5
16	45	1213	160281	Y	6
17	45	1214	160320	Y	7
18	45	1213	160287	N	8
19	45	1214	160321	Y	9
20	47	1211	160251	Y	1
21	47	1208	160176	Y	2
22	47	1211	160253	N	3
23	47	1208	160183	N	4
24	47	1211	160234	Y	5
25	47	1208	160177	N	6
26	47	1211	160252	N	7
27	47	1208	160173	Y	8
28	47	1211	160235	N	9
29	47	1208	160180	N	10
30	47	1211	160244	Y	11
31	47	1208	160168	Y	12
32	47	1211	160246	Y	13
33	47	1208	160169	Y	14
34	47	1211	160238	Y	15
35	47	1208	160165	Y	16
36	47	1211	160237	N	17
37	47	1208	160166	Y	18

#player_booked
match_no	team_id	player_id	booking_time	sent_off	play_schedule	play_half
1	1216	160349	32		NT	1
1	1216	160355	45		NT	1
1	1207	160159	69	Y	NT	2
1	1216	160360	78		NT	2
2	1221	160470	14		NT	1
2	1201	160013	23		NT	1
2	1201	160013	36		NT	1
2	1201	160014	63		NT	2
2	1221	160472	66		NT	2
2	1201	160015	89		NT	2
2	1201	160009	93		NT	2
3	1218	160401	2		ST	2
3	1218	160406	31		NT	1
3	1218	160408	78		NT	2
3	1218	160411	80		NT	2
3	1218	160407	83		NT	2
4	1206	160120	62		NT	2
4	1217	160377	72		NT	2
5	1222	160505	31		NT	1
5	1222	160490	48		NT	2
5	1204	160077	80		NT	2
5	1222	160502	91		NT	2
6	1213	160290	65		NT	2
6	1212	160258	69		NT	2
6	1213	160284	89		NT	2
7	1223	160518	68		NT	2
8	1205	160100	61		NT	2
9	1215	160336	43		NT	1
9	1220	160445	61		NT	2
9	1215	160341	77		NT	2
10	1211	160236	65		NT	2
10	1211	160248	75		NT	2
10	1211	160235	78		NT	2
10	1211	160245	84		NT	2
10	1203	160057	93		NT	2
11	1202	160027	33		NT	1
11	1202	160027	66	Y	NT	2
11	1209	160204	80		NT	2
12	1210	160227	2		ST	2
12	1210	160221	55		NT	2
13	1218	160395	46		NT	2
14	1221	160480	2		ST	2
14	1216	160361	22		NT	1
14	1216	160357	24		NT	1
14	1216	160367	37		NT	1
14	1221	160477	50		NT	2
14	1216	160352	76		NT	2
15	1201	160015	55		NT	2
15	1201	160011	81		NT	2
15	1207	160152	88		NT	2
16	1224	160535	61		NT	2
17	1223	160528	40		NT	1
17	1212	160272	63		NT	2
17	1223	160523	67		NT	2
17	1212	160266	87		NT	2
17	1212	160259	90		NT	2
18	1208	160175	3		NT	1
18	1213	160294	3		ST	2
18	1208	160177	34		NT	1
18	1213	160293	45		NT	1
18	1213	160288	55		NT	2
18	1208	160165	67		NT	2
19	1211	160242	69		NT	2
19	1220	160447	89		NT	2
19	1211	160231	94		NT	2
20	1204	160080	14		NT	1
20	1205	160101	72		NT	2
20	1204	160081	74		NT	2
20	1204	160078	88		NT	2
21	1219	160424	2		NT	1
21	1222	160504	9		NT	1
21	1222	160500	41		NT	1
22	1215	160334	42		NT	1
22	1203	160056	49		NT	2
23	1209	160199	2		ST	2
23	1210	160229	42		NT	1
23	1210	160227	75		NT	2
23	1210	160216	77		NT	2
23	1209	160192	81		NT	2
23	1209	160197	83		NT	2
24	1202	160028	6		NT	1
24	1214	160321	31		NT	1
24	1214	160307	40		NT	1
24	1202	160037	47		NT	2
24	1202	160029	78		NT	2
24	1202	160042	86		NT	2
25	1201	160012	6		NT	1
25	1216	160353	54		NT	2
25	1201	160017	85		NT	2
25	1216	160356	85		NT	2
25	1216	160364	91		NT	2
25	1201	160007	95		NT	2
26	1207	160147	25		NT	1
26	1207	160145	83		NT	2
27	1224	160551	16		NT	1
27	1217	160383	64		NT	2
28	1218	160409	24		NT	1
28	1206	160119	52		NT	2
29	1223	160520	25		NT	1
29	1223	160513	38		NT	1
29	1213	160290	60		NT	2
31	1222	160491	35		NT	1
31	1205	160108	36		NT	1
31	1205	160107	39	Y	NT	1
31	1222	160490	50		NT	2
31	1205	160112	87		NT	2
32	1204	160087	29		NT	1
32	1204	160079	70		NT	2
32	1204	160076	70		NT	2
32	1204	160085	88		NT	2
33	1210	160218	36		NT	1
33	1210	160230	51		NT	2
33	1202	160045	70		NT	2
33	1210	160220	78		NT	2
33	1210	160208	82		NT	2
34	1209	160190	13		NT	1
34	1209	160191	28		NT	1
34	1209	160203	34		NT	1
34	1209	160202	56		NT	2
35	1211	160233	39		NT	1
35	1215	160343	39		NT	1
35	1215	160332	73		NT	2
35	1211	160234	78		NT	2
35	1211	160253	87		NT	2
35	1211	160251	93		NT	2
36	1203	160064	1		ST	1
36	1203	160055	30		NT	1
36	1220	160451	72		NT	2
37	1221	160470	55		NT	2
37	1213	160282	58		NT	2
38	1212	160266	44		NT	1
38	1224	160538	58		NT	2
38	1212	160267	67		NT	2
38	1224	160544	92		NT	2
39	1214	160318	78		NT	2
40	1215	160328	25		NT	1
40	1207	160152	27		NT	1
40	1215	160334	41		NT	1
40	1207	160147	44		NT	1
40	1215	160329	66	Y	NT	2
40	1215	160343	72		NT	2
41	1218	160407	2		ST	2
41	1218	160401	13		NT	1
41	1208	160169	46		NT	2
41	1208	160168	67		NT	2
42	1209	160192	34		NT	1
42	1209	160194	47		NT	2
42	1209	160196	61		NT	2
42	1203	160056	67		NT	2
42	1203	160065	89		NT	2
42	1203	160061	91		NT	2
42	1209	160207	92		NT	2
43	1219	160431	2		ST	2
43	1211	160238	24		NT	1
43	1219	160436	41		NT	1
43	1211	160252	54		NT	2
43	1211	160245	89		NT	2
43	1219	160427	89		NT	2
43	1219	160421	89		NT	2
44	1210	160208	38		NT	1
44	1206	160137	47		NT	2
44	1210	160222	65		NT	2
45	1214	160318	2		ST	2
45	1213	160282	42		NT	1
45	1213	160281	66		NT	2
45	1214	160310	70		NT	2
45	1213	160290	89		NT	2
46	1224	160535	5		NT	1
46	1224	160533	16		NT	1
46	1224	160536	24		NT	1
46	1203	160061	59		NT	2
46	1224	160544	75		NT	2
46	1203	160050	85		NT	2
47	1211	160247	56		NT	2
47	1211	160238	57		NT	2
47	1211	160246	59		NT	2
47	1208	160168	90		NT	2
47	1208	160180	112		NT	2
48	1210	160221	58		NT	2
48	1207	160149	75		NT	2
49	1224	160540	8		NT	1
49	1224	160533	62		NT	2
49	1214	160303	71		NT	2
49	1214	160322	72		NT	2
49	1224	160547	88		NT	2
50	1208	160177	1		ST	1
50	1208	160172	36		NT	1
50	1207	160143	43		NT	1
50	1208	160180	45		NT	1
50	1208	160173	50		NT	2
50	1207	160152	75		NT	2
51	1214	160304	34		NT	1
51	1214	160313	62		NT	2
51	1207	160149	80		NT	2
51	1214	160308	95		ET	1
51	1207	160153	97		ET	1
51	1214	160318	98		ET	1
51	1207	160145	107		ET	2
51	1207	160155	115		ET	2
51	1214	160306	119		ET	2
51	1214	160302	122		ET	2

#player_in_out
match_no	team_id	player_id	in_out	time_in_out	play_schedule	play_half
1	1207	160151	I	66	NT	2
1	1207	160160	O	66	NT	2
1	1207	160161	I	77	NT	2
1	1207	160161	O	77	NT	2
1	1207	160157	I	2	ST	2
1	1207	160154	O	2	ST	2
1	1216	160365	I	61	NT	2
1	1216	160366	O	61	NT	2
1	1216	160357	I	72	NT	2
1	1216	160363	O	72	NT	2
1	1216	160364	I	82	NT	2
1	1216	160360	O	82	NT	2
2	1201	160014	I	62	NT	2
2	1201	160019	O	62	NT	2
2	1201	160021	I	74	NT	2
2	1201	160018	O	74	NT	2
2	1201	160022	I	82	NT	2
2	1201	160023	O	82	NT	2
2	1221	160480	I	62	NT	2
2	1221	160481	O	62	NT	2
2	1221	160475	I	76	NT	2
2	1221	160473	O	76	NT	2
2	1221	160474	I	88	NT	2
2	1221	160476	O	88	NT	2
3	1218	160413	I	59	NT	2
3	1218	160412	O	59	NT	2
3	1218	160403	I	60	NT	2
3	1218	160406	O	60	NT	2
3	1218	160410	I	83	NT	2
3	1218	160411	O	83	NT	2
3	1224	160543	I	69	NT	2
3	1224	160541	O	69	NT	2
3	1224	160550	I	71	NT	2
3	1224	160546	O	71	NT	2
3	1224	160537	I	88	NT	2
3	1224	160544	O	88	NT	2
4	1206	160133	I	78	NT	2
4	1206	160136	O	78	NT	2
4	1206	160131	I	87	NT	2
4	1206	160132	O	87	NT	2
4	1217	160386	I	77	NT	2
4	1217	160381	O	77	NT	2
4	1217	160380	I	80	NT	2
4	1217	160376	O	80	NT	2
4	1217	160383	I	85	NT	2
4	1217	160391	O	85	NT	2
5	1204	160090	I	87	NT	2
5	1204	160085	O	87	NT	2
5	1204	160075	I	90	NT	2
5	1204	160086	O	90	NT	2
5	1204	160092	I	3	ST	2
5	1204	160091	O	3	ST	2
5	1222	160502	I	46	NT	2
5	1222	160498	O	46	NT	2
5	1222	160504	I	65	NT	2
5	1222	160494	O	65	NT	2
5	1222	160506	I	69	NT	2
5	1222	160505	O	69	NT	2
6	1212	160266	I	46	NT	2
6	1212	160265	O	46	NT	2
6	1212	160276	I	66	NT	2
6	1212	160269	O	66	NT	2
6	1212	160272	I	76	NT	2
6	1212	160257	O	76	NT	2
6	1213	160289	I	78	NT	2
6	1213	160293	O	78	NT	2
6	1213	160288	I	80	NT	2
6	1213	160287	O	80	NT	2
6	1213	160294	I	88	NT	2
6	1213	160290	O	88	NT	2
7	1208	160179	I	78	NT	2
7	1208	160173	O	78	NT	2
7	1208	160180	I	90	NT	2
7	1208	160174	O	90	NT	2
7	1223	160528	I	66	NT	2
7	1223	160529	O	66	NT	2
7	1223	160526	I	73	NT	2
7	1223	160519	O	73	NT	2
8	1205	160113	I	75	NT	2
8	1205	160114	O	75	NT	2
8	1205	160112	I	86	NT	2
8	1205	160096	O	86	NT	2
8	1205	160107	I	88	NT	2
8	1205	160110	O	88	NT	2
8	1219	160433	I	62	NT	2
8	1219	160435	O	62	NT	2
8	1219	160432	I	70	NT	2
8	1219	160428	O	70	NT	2
8	1219	160437	I	82	NT	2
8	1219	160436	O	82	NT	2
9	1215	160337	I	64	NT	2
9	1215	160345	O	64	NT	2
9	1215	160342	I	78	NT	2
9	1215	160335	O	78	NT	2
9	1215	160338	I	85	NT	2
9	1215	160336	O	85	NT	2
9	1220	160444	I	45	NT	1
9	1220	160446	O	45	NT	1
9	1220	160458	I	59	NT	2
9	1220	160457	O	59	NT	2
9	1220	160449	I	86	NT	2
9	1220	160455	O	86	NT	2
10	1203	160068	I	62	NT	2
10	1203	160063	O	62	NT	2
10	1203	160069	I	73	NT	2
10	1203	160067	O	73	NT	2
10	1203	160058	I	76	NT	2
10	1203	160051	O	76	NT	2
10	1211	160238	I	58	NT	2
10	1211	160237	O	58	NT	2
10	1211	160250	I	75	NT	2
10	1211	160248	O	75	NT	2
10	1211	160245	I	78	NT	2
10	1211	160242	O	78	NT	2
11	1202	160041	I	59	NT	2
11	1202	160040	O	59	NT	2
11	1202	160046	I	65	NT	2
11	1202	160045	O	65	NT	2
11	1202	160042	I	77	NT	2
11	1202	160037	O	77	NT	2
11	1209	160206	I	69	NT	2
11	1209	160207	O	69	NT	2
11	1209	160200	I	79	NT	2
11	1209	160197	O	79	NT	2
11	1209	160195	I	89	NT	2
11	1209	160204	O	89	NT	2
12	1210	160227	I	81	NT	2
12	1210	160230	O	81	NT	2
12	1210	160211	I	90	NT	2
12	1210	160229	O	90	NT	2
12	1214	160316	I	71	NT	2
12	1214	160314	O	71	NT	2
12	1214	160321	I	76	NT	2
12	1214	160313	O	76	NT	2
12	1214	160319	I	84	NT	2
12	1214	160311	O	84	NT	2
13	1217	160380	I	46	NT	2
13	1217	160383	I	46	NT	2
13	1217	160376	O	46	NT	2
13	1217	160381	O	46	NT	2
13	1217	160386	I	75	NT	2
13	1217	160390	O	75	NT	2
13	1218	160413	I	67	NT	2
13	1218	160403	O	67	NT	2
13	1218	160402	I	72	NT	2
13	1218	160411	O	72	NT	2
13	1218	160412	I	80	NT	2
13	1218	160408	O	80	NT	2
14	1216	160358	I	46	NT	2
14	1216	160359	O	46	NT	2
14	1216	160350	I	62	NT	2
14	1216	160355	O	62	NT	2
14	1216	160366	I	84	NT	2
14	1216	160368	O	84	NT	2
14	1221	160480	I	63	NT	2
14	1221	160482	O	63	NT	2
14	1221	160466	I	83	NT	2
14	1221	160473	O	83	NT	2
14	1221	160483	I	90	NT	2
14	1221	160476	O	90	NT	2
15	1201	160018	I	71	NT	2
15	1201	160008	O	71	NT	2
15	1201	160019	I	74	NT	2
15	1201	160015	O	74	NT	2
15	1201	160010	I	85	NT	2
15	1201	160005	O	85	NT	2
15	1207	160155	I	46	NT	2
15	1207	160161	O	46	NT	2
15	1207	160160	I	68	NT	2
15	1207	160151	O	68	NT	2
15	1207	160158	I	77	NT	2
15	1207	160159	O	77	NT	2
16	1206	160138	I	46	NT	2
16	1206	160137	I	46	NT	2
16	1206	160134	O	46	NT	2
16	1206	160132	O	46	NT	2
16	1206	160135	I	73	NT	2
16	1206	160130	O	73	NT	2
16	1224	160541	I	67	NT	2
16	1224	160543	O	67	NT	2
16	1224	160546	I	72	NT	2
16	1224	160550	O	72	NT	2
17	1212	160275	I	69	NT	2
17	1212	160272	O	69	NT	2
17	1212	160270	I	84	NT	2
17	1212	160276	O	84	NT	2
17	1212	160265	I	87	NT	2
17	1212	160268	O	87	NT	2
17	1223	160529	I	71	NT	2
17	1223	160528	O	71	NT	2
17	1223	160516	I	76	NT	2
17	1223	160523	O	76	NT	2
17	1223	160526	I	83	NT	2
17	1223	160519	O	83	NT	2
18	1208	160179	I	66	NT	2
18	1208	160174	O	66	NT	2
18	1208	160182	I	71	NT	2
18	1208	160173	O	71	NT	2
18	1213	160289	I	76	NT	2
18	1213	160293	O	76	NT	2
18	1213	160290	I	80	NT	2
18	1213	160287	O	80	NT	2
18	1213	160294	I	87	NT	2
18	1213	160288	O	87	NT	2
19	1211	160253	I	60	NT	2
19	1211	160252	O	60	NT	2
19	1211	160245	I	74	NT	2
19	1211	160242	O	74	NT	2
19	1211	160247	I	85	NT	2
19	1211	160243	O	85	NT	2
19	1220	160455	I	79	NT	2
19	1220	160448	I	79	NT	2
19	1220	160449	O	79	NT	2
19	1220	160451	O	79	NT	2
19	1220	160457	I	85	NT	2
19	1220	160458	O	85	NT	2
20	1204	160083	I	62	NT	2
20	1204	160084	O	62	NT	2
20	1204	160075	I	90	NT	2
20	1204	160086	O	90	NT	2
20	1204	160079	I	2	ST	2
20	1204	160077	O	2	ST	2
20	1205	160115	I	67	NT	2
20	1205	160112	I	67	NT	2
20	1205	160113	O	67	NT	2
20	1205	160111	O	67	NT	2
20	1205	160114	I	86	NT	2
20	1205	160108	O	86	NT	2
21	1219	160426	I	64	NT	2
21	1219	160431	O	64	NT	2
21	1219	160430	I	71	NT	2
21	1219	160428	O	71	NT	2
21	1219	160418	I	81	NT	2
21	1219	160421	O	81	NT	2
21	1222	160497	I	46	NT	2
21	1222	160495	O	46	NT	2
21	1222	160499	I	62	NT	2
21	1222	160498	O	62	NT	2
21	1222	160503	I	70	NT	2
21	1222	160501	O	70	NT	2
22	1203	160063	I	57	NT	2
22	1203	160060	O	57	NT	2
22	1203	160068	I	64	NT	2
22	1203	160058	O	64	NT	2
22	1203	160066	I	83	NT	2
22	1203	160067	O	83	NT	2
22	1215	160337	I	62	NT	2
22	1215	160336	O	62	NT	2
22	1215	160338	I	71	NT	2
22	1215	160335	O	71	NT	2
22	1215	160342	I	79	NT	2
22	1215	160343	O	79	NT	2
23	1209	160201	I	66	NT	2
23	1209	160205	I	66	NT	2
23	1209	160206	O	66	NT	2
23	1209	160200	O	66	NT	2
23	1209	160207	I	84	NT	2
23	1209	160191	O	84	NT	2
23	1210	160223	I	65	NT	2
23	1210	160222	O	65	NT	2
23	1210	160227	I	69	NT	2
23	1210	160226	O	69	NT	2
23	1210	160228	I	84	NT	2
23	1210	160230	O	84	NT	2
24	1202	160042	I	65	NT	2
24	1202	160034	O	65	NT	2
24	1202	160044	I	85	NT	2
24	1202	160041	O	85	NT	2
24	1202	160033	I	87	NT	2
24	1202	160038	O	87	NT	2
24	1214	160313	I	71	NT	2
24	1214	160321	O	71	NT	2
24	1214	160319	I	83	NT	2
24	1214	160311	O	83	NT	2
24	1214	160315	I	89	NT	2
24	1214	160320	O	89	NT	2
25	1201	160020	I	59	NT	2
25	1201	160023	O	59	NT	2
25	1201	160018	I	77	NT	2
25	1201	160016	O	77	NT	2
25	1201	160013	I	83	NT	2
25	1201	160012	O	83	NT	2
25	1216	160362	I	46	NT	2
25	1216	160361	O	46	NT	2
25	1216	160364	I	57	NT	2
25	1216	160365	O	57	NT	2
25	1216	160366	I	68	NT	2
25	1216	160360	O	68	NT	2
26	1207	160154	I	63	NT	2
26	1207	160151	O	63	NT	2
26	1207	160153	I	77	NT	2
26	1207	160160	O	77	NT	2
26	1221	160482	I	74	NT	2
26	1221	160480	O	74	NT	2
26	1221	160474	I	79	NT	2
26	1221	160476	O	79	NT	2
26	1221	160466	I	86	NT	2
26	1221	160481	O	86	NT	2
27	1217	160372	I	46	NT	2
27	1217	160373	O	46	NT	2
27	1217	160381	I	52	NT	2
27	1217	160386	O	52	NT	2
27	1217	160384	I	70	NT	2
27	1217	160391	O	70	NT	2
27	1224	160541	I	74	NT	2
27	1224	160540	O	74	NT	2
27	1224	160542	I	76	NT	2
27	1224	160543	O	76	NT	2
27	1224	160548	I	83	NT	2
27	1224	160547	O	83	NT	2
28	1206	160136	I	56	NT	2
28	1206	160133	O	56	NT	2
28	1206	160126	I	61	NT	2
28	1206	160130	O	61	NT	2
28	1206	160134	I	76	NT	2
28	1206	160137	O	76	NT	2
28	1218	160402	I	57	NT	2
28	1218	160403	O	57	NT	2
28	1218	160396	I	67	NT	2
28	1218	160409	O	67	NT	2
28	1218	160400	I	78	NT	2
28	1218	160411	O	78	NT	2
29	1213	160287	I	46	NT	2
29	1213	160296	O	46	NT	2
29	1213	160288	I	71	NT	2
29	1213	160290	O	71	NT	2
29	1213	160295	I	3	ST	2
29	1213	160298	O	3	ST	2
29	1223	160519	I	73	NT	2
29	1223	160526	O	73	NT	2
29	1223	160524	I	1	ST	2
29	1223	160529	O	1	ST	2
30	1208	160179	I	55	NT	2
30	1208	160174	O	55	NT	2
30	1208	160180	I	69	NT	2
30	1208	160175	O	69	NT	2
30	1208	160167	I	76	NT	2
30	1208	160165	O	76	NT	2
30	1212	160274	I	59	NT	2
30	1212	160276	O	59	NT	2
30	1212	160270	I	70	NT	2
30	1212	160272	O	70	NT	2
30	1212	160275	I	84	NT	2
30	1212	160268	O	84	NT	2
31	1205	160115	I	57	NT	2
31	1205	160107	O	57	NT	2
31	1205	160112	I	71	NT	2
31	1205	160104	O	71	NT	2
31	1205	160105	I	90	NT	2
31	1205	160108	O	90	NT	2
31	1222	160498	I	61	NT	2
31	1222	160502	O	61	NT	2
31	1222	160499	I	69	NT	2
31	1222	160506	O	69	NT	2
31	1222	160505	I	90	NT	2
31	1222	160504	O	90	NT	2
32	1204	160083	I	82	NT	2
32	1204	160087	O	82	NT	2
32	1204	160088	I	90	NT	2
32	1204	160092	O	90	NT	2
32	1204	160090	I	2	ST	2
32	1204	160085	O	2	ST	2
32	1219	160426	I	60	NT	2
32	1219	160436	O	60	NT	2
32	1219	160433	I	67	NT	2
32	1219	160435	O	67	NT	2
32	1219	160432	I	84	NT	2
32	1219	160428	O	84	NT	2
33	1202	160042	I	46	NT	2
33	1202	160045	I	46	NT	2
33	1202	160031	O	46	NT	2
33	1202	160038	O	46	NT	2
33	1202	160039	I	78	NT	2
33	1202	160041	O	78	NT	2
33	1210	160211	I	71	NT	2
33	1210	160226	O	71	NT	2
33	1210	160219	I	80	NT	2
33	1210	160230	O	80	NT	2
33	1210	160214	I	86	NT	2
33	1210	160229	O	86	NT	2
34	1209	160188	I	46	NT	2
34	1209	160203	O	46	NT	2
34	1209	160204	I	71	NT	2
34	1209	160207	O	71	NT	2
34	1209	160200	I	83	NT	2
34	1209	160198	O	83	NT	2
34	1214	160316	I	46	NT	2
34	1214	160314	O	46	NT	2
34	1214	160321	I	61	NT	2
34	1214	160311	O	61	NT	2
34	1214	160313	I	81	NT	2
34	1214	160320	O	81	NT	2
35	1211	160237	I	60	NT	2
35	1211	160240	O	60	NT	2
35	1211	160251	I	74	NT	2
35	1211	160250	O	74	NT	2
35	1211	160249	I	81	NT	2
35	1211	160238	O	81	NT	2
35	1215	160338	I	70	NT	2
35	1215	160344	O	70	NT	2
35	1215	160335	I	77	NT	2
35	1215	160336	O	77	NT	2
35	1215	160340	I	90	NT	2
35	1215	160343	O	90	NT	2
36	1203	160068	I	71	NT	2
36	1203	160058	O	71	NT	2
36	1203	160066	I	87	NT	2
36	1203	160067	O	87	NT	2
36	1203	160069	I	2	ST	2
36	1203	160062	O	2	ST	2
36	1220	160458	I	63	NT	2
36	1220	160457	O	63	NT	2
36	1220	160448	I	70	NT	2
36	1220	160454	O	70	NT	2
36	1220	160450	I	82	NT	2
36	1220	160451	O	82	NT	2
37	1213	160289	I	101	ET	1
37	1213	160293	O	101	ET	1
37	1213	160294	I	104	ET	1
37	1213	160288	O	104	ET	1
37	1221	160480	I	58	NT	2
37	1221	160473	O	58	NT	2
37	1221	160479	I	70	NT	2
37	1221	160481	O	70	NT	2
37	1221	160474	I	77	NT	2
37	1221	160472	O	77	NT	2
38	1212	160276	I	69	NT	2
38	1212	160272	O	69	NT	2
38	1212	160275	I	79	NT	2
38	1212	160271	O	79	NT	2
38	1212	160270	I	84	NT	2
38	1212	160262	O	84	NT	2
38	1224	160550	I	55	NT	2
38	1224	160551	O	55	NT	2
38	1224	160546	I	63	NT	2
38	1224	160543	O	63	NT	2
39	1204	160092	I	110	ET	2
39	1204	160086	O	110	ET	2
39	1204	160090	I	120	ET	2
39	1204	160073	O	120	ET	2
39	1204	160089	I	88	NT	2
39	1204	160091	O	88	NT	2
39	1214	160313	I	117	ET	2
39	1214	160310	O	117	ET	2
39	1214	160316	I	50	NT	2
39	1214	160311	O	50	NT	2
39	1214	160321	I	87	NT	2
39	1214	160313	O	87	NT	2
40	1207	160151	I	46	NT	2
40	1207	160152	O	46	NT	2
40	1207	160158	I	73	NT	2
40	1207	160159	O	73	NT	2
40	1207	160157	I	2	ST	2
40	1207	160151	O	2	ST	2
40	1215	160345	I	65	NT	2
40	1215	160344	O	65	NT	2
40	1215	160331	I	68	NT	2
40	1215	160337	O	68	NT	2
40	1215	160335	I	71	NT	2
40	1215	160336	O	71	NT	2
41	1208	160167	I	72	NT	2
41	1208	160184	I	72	NT	2
41	1208	160165	O	72	NT	2
41	1208	160173	O	72	NT	2
41	1208	160180	I	76	NT	2
41	1208	160175	O	76	NT	2
41	1218	160404	I	46	NT	2
41	1218	160411	O	46	NT	2
41	1218	160414	I	64	NT	2
41	1218	160412	O	64	NT	2
41	1218	160399	I	84	NT	2
41	1218	160396	O	84	NT	2
42	1203	160058	I	70	NT	2
42	1203	160068	O	70	NT	2
42	1203	160065	I	76	NT	2
42	1203	160067	O	76	NT	2
42	1203	160061	I	81	NT	2
42	1203	160062	O	81	NT	2
42	1209	160196	I	46	NT	2
42	1209	160203	O	46	NT	2
42	1209	160205	I	75	NT	2
42	1209	160195	O	75	NT	2
42	1209	160201	I	79	NT	2
42	1209	160191	O	79	NT	2
43	1211	160245	I	54	NT	2
43	1211	160242	O	54	NT	2
43	1211	160251	I	82	NT	2
43	1211	160248	O	82	NT	2
43	1211	160237	I	84	NT	2
43	1211	160243	O	84	NT	2
43	1219	160433	I	46	NT	2
43	1219	160436	O	46	NT	2
43	1219	160434	I	70	NT	2
43	1219	160435	O	70	NT	2
43	1219	160437	I	81	NT	2
43	1219	160433	O	81	NT	2
44	1206	160133	I	46	NT	2
44	1206	160128	O	46	NT	2
44	1206	160138	I	60	NT	2
44	1206	160132	O	60	NT	2
44	1206	160135	I	87	NT	2
44	1206	160136	O	87	NT	2
44	1210	160211	I	76	NT	2
44	1210	160230	O	76	NT	2
44	1210	160219	I	89	NT	2
44	1210	160226	O	89	NT	2
45	1213	160289	I	98	ET	1
45	1213	160293	O	98	ET	1
45	1213	160290	I	82	NT	2
45	1213	160288	O	82	NT	2
45	1214	160313	I	96	ET	1
45	1214	160318	O	96	ET	1
45	1214	160314	I	70	NT	2
45	1214	160310	O	70	NT	2
45	1214	160321	I	80	NT	2
45	1214	160313	O	80	NT	2
46	1203	160061	I	46	NT	2
46	1203	160058	O	46	NT	2
46	1203	160068	I	75	NT	2
46	1203	160054	O	75	NT	2
46	1203	160065	I	83	NT	2
46	1203	160067	O	83	NT	2
46	1224	160542	I	78	NT	2
46	1224	160543	O	78	NT	2
46	1224	160551	I	80	NT	2
46	1224	160550	O	80	NT	2
46	1224	160534	I	90	NT	2
46	1224	160544	O	90	NT	2
47	1208	160180	I	16	NT	1
47	1208	160175	O	16	NT	1
47	1208	160173	I	72	NT	2
47	1208	160182	O	72	NT	2
47	1211	160253	I	120	ET	2
47	1211	160236	O	120	ET	2
47	1211	160237	I	86	NT	2
47	1211	160243	O	86	NT	2
47	1211	160251	I	108	NT	2
47	1211	160248	O	108	NT	2
48	1207	160158	I	60	NT	2
48	1207	160159	O	60	NT	2
48	1207	160146	I	72	NT	2
48	1207	160145	O	72	NT	2
48	1207	160151	I	80	NT	2
48	1207	160154	O	80	NT	2
48	1210	160214	I	46	NT	2
48	1210	160227	I	46	NT	2
48	1210	160220	O	46	NT	2
48	1210	160226	O	46	NT	2
48	1210	160228	I	83	NT	2
48	1210	160230	O	83	NT	2
49	1214	160311	I	74	NT	2
49	1214	160316	O	74	NT	2
49	1214	160314	I	79	NT	2
49	1214	160310	O	79	NT	2
49	1214	160321	I	86	NT	2
49	1214	160320	O	86	NT	2
49	1224	160551	I	58	NT	2
49	1224	160543	O	58	NT	2
49	1224	160548	I	63	NT	2
49	1224	160550	O	63	NT	2
49	1224	160546	I	66	NT	2
49	1224	160534	O	66	NT	2
50	1207	160152	I	71	NT	2
50	1207	160154	O	71	NT	2
50	1207	160158	I	78	NT	2
50	1207	160159	O	78	NT	2
50	1207	160150	I	2	ST	2
50	1207	160160	O	2	ST	2
50	1208	160170	I	61	NT	2
50	1208	160165	O	61	NT	2
50	1208	160174	I	67	NT	2
50	1208	160172	O	67	NT	2
50	1208	160178	I	79	NT	2
50	1208	160180	O	79	NT	2
51	1207	160161	I	110	ET	2
51	1207	160154	O	110	ET	2
51	1207	160151	I	58	NT	2
51	1207	160154	O	58	NT	2
51	1207	160158	I	78	NT	2
51	1207	160159	O	78	NT	2
51	1214	160321	I	25	NT	1
51	1214	160322	O	25	NT	1
51	1214	160314	I	66	NT	2
51	1214	160310	O	66	NT	2
51	1214	160319	I	79	NT	2
51	1214	160316	O	79	NT	2

#match_captain
match_no	team_id	player_captain
1	1207	160140
1	1216	160349
2	1201	160013
2	1221	160467
3	1224	160539
3	1218	160401
4	1206	160136
4	1217	160373
5	1222	160494
5	1204	160076
6	1213	160297
6	1212	160267
7	1208	160163
7	1223	160515
8	1219	160424
8	1205	160110
9	1215	160331
9	1220	160459
10	1203	160062
10	1211	160231
11	1202	160028
11	1209	160202
12	1214	160322
12	1210	160222
13	1217	160373
13	1218	160401
14	1216	160349
14	1221	160467
15	1207	160140
15	1201	160004
16	1206	160136
16	1224	160539
17	1223	160515
17	1212	160267
18	1208	160163
18	1213	160297
19	1211	160231
19	1220	160459
20	1205	160110
20	1204	160076
21	1219	160424
21	1222	160494
22	1203	160062
22	1215	160331
23	1210	160222
23	1209	160202
24	1214	160322
24	1202	160028
25	1216	160349
25	1201	160004
26	1221	160467
26	1207	160140
27	1217	160386
27	1224	160539
28	1218	160401
28	1206	160120
29	1223	160520
29	1213	160297
30	1212	160267
30	1208	160163
31	1205	160093
31	1222	160494
32	1204	160076
32	1219	160424
33	1210	160222
33	1202	160028
34	1209	160202
34	1214	160322
35	1211	160235
35	1215	160328
36	1220	160459
36	1203	160062
37	1221	160467
37	1213	160297
38	1224	160539
38	1212	160267
39	1204	160076
39	1214	160322
40	1207	160140
40	1215	160328
41	1208	160163
41	1218	160401
42	1209	160202
42	1203	160062
43	1211	160231
43	1219	160424
44	1206	160136
44	1210	160222
45	1213	160297
45	1214	160322
46	1224	160539
46	1203	160062
47	1208	160163
47	1211	160231
48	1207	160140
48	1210	160222
49	1214	160322
49	1224	160539
50	1207	160140
50	1208	160180
51	1214	160322
51	1207	160140

#team_coaches
team_id	coach_id
1201	5550
1202	5551
1203	5552
1204	5553
1205	5554
1206	5555
1207	5556
1208	5557
1209	5558
1210	5559
1210	5560
1211	5561
1212	5562
1213	5563
1214	5564
1215	5565
1216	5566
1217	5567
1218	5568
1219	5569
1220	5570
1221	5571
1222	5572
1223	5573
1224	5574

#penalty_gk
match_no	team_id	player_gk
37	1221	160463
37	1213	160278
45	1213	160278
45	1214	160302
47	1208	160163
47	1211	160231
*/

/*
Description of tables:

soccer_country:
country_id – this is a unique ID for each country
country_abbr – this is the sort name of each country
country_name – this is the name of each country

soccer_city:
city_id – this is a unique ID for each city
city – this is the name of the city
country_id – this is the ID of the country where the cities are located and only those countries will be available which are in soccer_country table

soccer_venue:
venue_id – this is a unique ID for each venue
venue_name – this is the name of the venue
city_id – this is the ID of the city where the venue is located and only those cities will be available which are in the soccer_city table
aud_capicity – this is the capacity of audience for each venue

soccer_team:
team_id – this is the ID for each team. Each teams are representing to a country which are referencing the country_id column of soccer_country table
team_group – the name of the group in which the team belongs
match_played – how many matches a team played in group stage
won – how many matches a team won
draw – how many matches a team draws
lost – how many matches a team lose
goal_for – how many goals a team conceded
goal_agnst – how many goals a team scored
goal_diff – the difference of goal scored and goal conceded
points – how many points a team achieved from their group stage matches
group_position – in which position a team finished their group stage matches

playing_position:
position_id – this is a unique ID for each position where a player played
position_desc – this is the name of the position where a player played

player_mast:
player_id – this is a unique ID for each player
team_id – this is the team where a player played, and only those teams which referencing the country_id column of the table soccer_country
jersey_no – the number which labeled on the jersey for each player
player_name – name of the player
posi_to_play – the position where a player played, and the positions are referencing the position_id column of playing_position table
dt_of_bir – date of birth of each player
age – approximate age at the time of playing the tournament
playing_club – the name of the club for which a player was playing at the time of the tournament

referee_mast:
referee_id – this is the unique ID for each referee
referee_name – name of the referee
country_id – the country, where a referee belongs and the countries are those which referencing the country_id column of soccer_country table

match_mast:
match_no – this if the unique ID for a match
play_stage – this indicates that in which stage a match is going on, i.e. G for Group stage, R for Round of 16 stage, Q for Quarter final stage, S for Semi Final stage, and F for Final
play_date – date of the match played
results – the result of the match, either win or draw
decided_by – how the result of the match has been decided, either N for by normally or P for by penalty shootout
goal_score – score for a match
venue_id – the venue where the match played and the venue will be one of the venue referencing the venue_id column of soccer_venue table
referee_id – ID of the referee who is selected for the match which referencing the referee_id column of referee_mast table
audence – number of audience appears to watch the match
plr_of_match – this is the player who awarded the player of a particular match and who is selected a 23 men playing squad for a team which referencing the player_id column of player_mast table
stop1_sec – how many stoppage time ( in second) have been added for the 1st half of play
stop2_sec – how many stoppage time ( in second) have been added for the 2nd half of play

coach_mast:
coach_id – this is the unique ID for a coach
coach_name – this is the name of the coach

asst_referee_mast:
ass_ref_id – this is the unique ID for each referee assists the main referee
ass_ref_name – name of the assistant referee
country_id – the country where an assistant referee belongs and the countries are those which are referencing the country_id column of soccer_country table

match_details:
match_no – number of the match which is referencing the match_no column of match_mast table
play_stage - stage of the match, i.e. G for group stage, R for Round of 16, Q for Quarter Final, S for Semi final and F for final
team_id – the team which is one of the playing team and it is referencing the country_id column of soccer_country table
win_lose – team either win or lose or drawn indicated by the character W, L, or D
decided_by - how the result achieved by the team, indicated N for normal score or P for penalty shootout
goal_score – how many goal scored by the team
penalty_score – how many goal scored by the team in penalty shootout
ass_ref – the assistant referee assist the referee which are referencing the ass_ref_id column of asst_referee_mast table
player_gk - the player who is keeping the goal for the team, is referencing the player_id column of player_mast table

goal_details:
goal_id – this is the unique ID for each goal
match_no – this is match_no which is referencing the match_no column of match_mast table
player_id - this is the ID of a player who is selected for the 23 men squad of a team for the tournament and which is referencing the player_id column of player_mast table
team_id – this is the ID of each team who are playing in the tournament and referencing the country_id column of soccer_country table
goal_time – this is the time when the goal scored
goal_type – this is the type of goal which came in normally indicated by N or own goal indicating by O and goal came from penalty indicated by P
play_stage – this is the play stage in which goal scored, indicated by G for group stage, R for round of 16 stage, Q for quarter final stage, S for semifinal stage and F for final match
goal_schedule – when the goal came, is it normal play session indicated by NT or in stoppage time indicated by ST or in extra time indicated by ET
goal_half – in which half of match goal came

penalty_shootout:
kick_id – this is unique ID for each penalty kick
match_no - this is the match_no which is referencing the match_no column of match_mast table
team_id – this is the ID of each team who is playing in the tournament and referencing the country_id column of soccer_country table
player_id - this is the ID of a player who is selected for the 23 men squad of a team for the tournament and which is referencing the player_id column of player_mast table
score_goal – this is the flag Y if able to score the goal or N when not
kick_no – this is the kick number for the kick of an individual match

player_booked:
match_no - this is the match_no which is referencing the match_no column of match_mast table
team_id – this is the ID of each team who are playing in the tournament and referencing the country_id column of soccer_country table
player_id - this is the ID of a player who is selected for the 23 men squad of a team for the tournament and which is referencing the player_id column of player_mast table
booking_time – this is the time when a player booked
sent_off – this is the flag Y when a player sent off
play_schedule – when a player booked, is it in normal play session indicated by NT or in stoppage time indicated by ST or in extra time indicated by ET
play_half – in which half a player booked

player_in_out:
match_no - this is the match_no which is referencing the match_no column of match_mast table
team_id – this is the ID of each team who are playing in the tournament and referencing the country_id column of soccer_country table
player_id - this is the ID of a player who is selected for the 23 men squad of a team for the tournament and which is referencing the player_id column of player_mast table
in_out – this is the flag I when a player came into the field or O when go out from the field
time_in_out – when a player come into the field or go out from the field
play_schedule – when a player come in or go out of the field, is it in normal play session indicated by NT or in stoppage time indicated by ST or in extra time indicated by ET
play_half - in which half a player come in or go out

match_captain:
match_no - this is the match_no which is referencing the match_no column of match_mast table
team_id – this is the ID of each team who are playing in the tournament and referencing the country_id column of soccer_country table
player_captain - the player who represents as a captain for a team, is referencing the player_id column of player_mast table

team_coaches:
team_id – this is the ID of a team who is playing in the tournament and referencing the country_id column of soccer_country table
coach_id – a team may be one or more coaches, this indicates the coach(s) who is/are coaching the team is referencing the coach_id column of coach_mast table

penalty_gk:
match_no - this is the match_no which is referencing the match_no column of match_mast table
team_id – this is the ID of each team who are playing in the tournament and referencing the country_id column of soccer_country table
player_gk - the player who kept goal at the time of penalty shootout, is referencing the player_id column of player_mast table
*/