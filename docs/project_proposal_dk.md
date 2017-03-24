# DDOS DETECTION AND MITIGATION SERVICE

### Projektstiller: Tangui Coulouarn

#### Abstract

Når institutioner/tjenester på Forskningsnettet i dag bliver ramt af DDoS
angreb, kan Forskningsnettets NOC først blokere angreb efter de er blevet
kontaktet af IT-ansvarlige på de ramte institutioner ved at tilføje manuelt
firewall regler og/eller ”black hole” routning manuelt. Det tager tid og det er
ineffektivt: i mange tilfælde bliver al trafik til den ramte institution
forstyrret.  Med den DDoS Detection and Mitigation Service, som bliver
beskrevet i dette dokument, vil netværksadministratorer på de tilsluttede
institutioner selv kunne skabe og udbrede firewall regler via en webportal.
Reglerne bliver også mere præcise, da tjenesten vil bruge BGP FlowSpec (RFC
5575), hvor specifikke flows kan stoppes uden at blokere hele trafikken. 

## PROJEKTETS VISION

Institutioner på Forskningsnettet bliver beskyttet mod DDoS angreb:

  -	hurtigere (1), da ramte institutioner selv kan skabe og disseminere filters for trafik flows til og fra deres adresser;
  -	hurtigere (2), fordi systemet vil bruge effektivt monitering af flows;
  -	på en mere brugervenlig måde, da deres input vil ske på en dedikeret webportal, hvor reglerne vil kunne skabes og administreres uafhængigt af det specifik hardware, hor de vil implementeres;
  -	på en mere overskuelig måde, da webportalen vil også bruges til at tjekke, ændre og slette eksisterende regler.


