# UX English

Corso di inglese per UX/UI designer, come web app ottimizzata per iPhone (stile Apple, tema scuro e chiaro).
Basato sulla *Activity Guide for Teaching English as a Foreign Language* (TEFL Full Circle) e sul metodo dei "trick" con formula a colori.

## Contenuti
6 moduli × 5 lezioni (4 lezioni + 1 sfida finale):

| Modulo | Focus | Dalla guida |
|---|---|---|
| Il tuo studio | Presente: BE, la S, DO, -ing, avverbi | The Present, routine |
| Portfolio e case study | Passato, DID, was + -ing, present perfect | The Past, jumbled paragraphs |
| Roadmap e piani | will / going to, will have, if / when, modali | The Future |
| Il lessico UI | componenti, phrasal verbs, falsi amici, comparativi | Vocabulary, Splat, matching |
| Design critique e meeting | opinioni, interrompere, accordo, chiudere | Speaking, role play, debates |
| Pronuncia e ascolto | word stress, minimal pairs, dettato, stand-up | Phonology, Listening |

## Metodo LOOP (70% pratica · 30% teoria)
- **Look**: un trick breve (regola, formula a colori, trappola per italiani)
- **Operate**: 7-10 esercizi in 11 formati (scegli, completa, riordina, correggi, traduci, abbina, riconosci il componente, accento, coppie minime, dettato, shadowing)
- **Out loud**: sintesi vocale inglese (US/UK) per ascoltare e ripetere
- **Park**: gli errori entrano nel Ripasso dilazionato (1, 3, 7, 14, 30 giorni)

Tecniche: pre-test, richiamo attivo, ripetizione dilazionata, interleaving (Mix del giorno), dual coding, chunking, shadowing.

## Struttura
- `src/corso.html`: sorgente (contenuti + app)
- `scripts/build.sh`: genera `index.html` autonomo
- `index.html`: da aprire nel browser o pubblicare su GitHub Pages

I progressi sono salvati nel browser (localStorage); dal menu si possono copiare e importare su un altro dispositivo.

## Account e database (Supabase)
Login, registrazione e progressi vivono su Supabase (Postgres + Auth):
- tabella `profiles`: nome ed email di ogni account;
- tabella `progress`: tutti i dati del corso (lezioni, esercizi visti, ripasso, XP, serie, impostazioni) più le colonne `xp`, `best_streak`, `lessons_done` per consultarli facilmente.
Ognuno vede solo i propri dati (Row Level Security). I progressi si salvano da soli dopo ogni esercizio, restano in cache sul dispositivo se si è offline e vengono inviati al ritorno della connessione.

Attivazione:
1. Supabase › SQL Editor: esegui `supabase/schema.sql`.
2. Authentication › URL Configuration: *Site URL* `https://andreagalanti91.github.io/corsoinglese/` (serve per i link di conferma e di recupero password).
3. In `src/corso.html` inserisci *Project URL* e *anon public key* in `CLOUD`, poi `./scripts/build.sh` e push.

Senza configurazione l'app usa account salvati solo sul dispositivo.

## Frasi sempre nuove
Ogni lezione usa prima gli esercizi scritti a mano, poi dei generatori (soggetti, verbi, oggetti e tempi del lavoro di un designer) che producono migliaia di varianti. Ogni esercizio visto viene segnato: rifacendo o ricominciando una lezione arrivano solo esercizi nuovi.
