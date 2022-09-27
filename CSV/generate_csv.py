import csv
import random
import  math
import pycountry_convert as pc
import datetime
import pycountry
countries = [i.name for i in pycountry.countries]

navires = ["Yacht","Flute","Galion","Gabare","Post-Panamax"]

relationD = ["allies","allies commerciaux","neutres", "en guerre"]

def random_date(start_date,end_date):
    time_between_dates = end_date - start_date
    days_between_dates = time_between_dates.days
    random_number_of_days = random.randrange(days_between_dates)
    res = start_date + datetime.timedelta(days=random_number_of_days)
    return res

def country_to_continent(country_name):
    country_alpha2 = pc.country_name_to_country_alpha2(country_name)
    country_continent_code = pc.country_alpha2_to_continent_code(country_alpha2)
    country_continent_name = pc.convert_continent_code_to_continent_name(country_continent_code)
    return country_continent_name

def randlatlon1():
    pi = math.pi
    cf = 180.0 / pi  # radians to degrees Correction Factor
    u0 = random.uniform(0.0, 1.0)
    u1 = random.uniform(0.0, 1.0)
    radLat = math.asin(2*u0 - 1.0)  # angle with Equator   - from +pi/2 to -pi/2
    radLon = (2*u1 - 1) * pi        # longitude in radians - from -pi to +pi
    return (round(radLat*cf,5), round(radLon*cf,5))

nation = open("nation.csv", "w", newline='')
nationwriter = csv.writer(nation,delimiter=",",quotechar='|',quoting= csv.QUOTE_MINIMAL)
rnation = random.choices(countries,k=20)
continents = [country_to_continent(i) for i in rnation]
for i in range(1,21):
    nationwriter.writerow([str(i),rnation[i-1]])
relationdiplo = nation = open("relationdiplo.csv", "w", newline='')
relationdiplowriter = csv.writer(relationdiplo,delimiter=",",quotechar='|',quoting= csv.QUOTE_MINIMAL)
relationvoyage = [["" for i in range(20)] for j in range(20)]
for i in range(1,21):
    for j in range(i+1,21):
        relation = random.choice(relationD)
        relationdiplowriter.writerow([str(i),str(j),relation])
        relationvoyage[i-1][j-1] = relation
        relationvoyage[j-1][i-1] = relation

portlonlat = []
port = open("port.csv", "w", newline='')
portcateg = []
portnat = []
portwriter = csv.writer(port,delimiter=",",quotechar='|',quoting= csv.QUOTE_MINIMAL)
for i in range(1,81):
    lon,lat = randlatlon1()
    while((lon,lat) in portlonlat):
        lon,lat = randlatlon1()
    nat = random.randint(1,20)
    continent = continents[nat-1]
    categ = random.randint(1,5)
    portcateg.append(categ)
    portlonlat.append((lon,lat))
    portnat.append(nat)
    portwriter.writerow([str(i),"Port"+str(i),str(continent),str(nat),str(categ),str(random.randint(1,300))])

navire = open("navire.csv","w",newline='')
navireIntervalle = [1,100,1000,10000,100000,650000]
passagerIntervalle = [1,10,100,1000,3000,6000]
navirecateg = []
navirenat = []
navirevolume = []
navirepassager = []
navirewriter = csv.writer(navire,delimiter=",",quotechar='|',quoting= csv.QUOTE_MINIMAL)
for i in range(1,101):
    type = random.randint(1,5)
    nat = random.randint(1,20)
    volume = random.randint(navireIntervalle[type-1],navireIntervalle[type]-1)
    passager = random.randint(passagerIntervalle[type-1],passagerIntervalle[type])
    navirecateg.append(type)
    navirenat.append(nat)
    navirevolume.append(volume)
    navirepassager.append(passager)
    navirewriter.writerow([str(i),navires[type-1],str(type),str(nat),str(volume),str(passager)])

voyage = open("voyage.csv","w",newline='')
voyagewriter = csv.writer(voyage,delimiter=",",quotechar='|',quoting= csv.QUOTE_MINIMAL)
voyagesdates = [[] for j in range(101)]
distancesnat = [1,1000,2001,5000]
distances = [[0 for i in range(80)] for j in range(80)]
voyagestype = []
voyagesnavi = []
voyagenat = []
deltaday = 0
for i in range(1,101):
    portprov = random.randint(1,80)-1
    portdest = random.randint(1,80)-1
    natprov = portnat[portprov]-1
    natdest = portnat[portdest]-1
    navi = random.randint(1,100)-1
    type = random.randint(1,3)
    if(type==3):
        while(navirecateg[navi]!=5):
            navi = random.randint(1,100)-1
    while(relationvoyage[natprov][natdest] == "guerre" and navirecateg[navi]<=portcateg[portprov] and navirecateg<=portcateg[portdest]):
        portdest = random.randint(1,80)-1
        natdest = portnat[portdest]-1
    while(relationvoyage[natprov][navirenat[navi]-1]=="guerre" and navirecateg[navi]<=portcateg[portprov] and navirecateg<=portcateg[portdest]):
        navi = random.randint(1,100)
    start_date = random_date(datetime.date(1971,1,1), datetime.date(2022,5,24))
    for j in sorted(voyagesdates[i-1]):
        while(j[0]<=start_date<=j[1]):
            start_date = random_date(datetime.date(1971,1,1), datetime.date(2022,5,24))
    dist = random.randint(distancesnat[type-1],distancesnat[type]-1)
    if(distances[portprov][portdest] ==0):
        distances[portprov][portdest] = dist
        distances[portdest][portprov] = dist
    if(0<distances[portprov][portdest]<1000):
        type = 1
        end_date = random_date(start_date+datetime.timedelta(days=30),start_date+datetime.timedelta(days=40))
    elif(1000<=distances[portprov][portdest]<=2000):
        type = 2
        end_date = random_date(start_date+datetime.timedelta(days=50),start_date+datetime.timedelta(days=180))
    else:
        type = 3
        while(navirecateg[navi]!=5):
            navi = random.randint(1,100)-1
        end_date = random_date(start_date+datetime.timedelta(days=190),start_date+datetime.timedelta(days=450))
    if(type!=1 and continents[natprov]!=continents[natdest]):
        while(navirecateg[navi]!=5):
            navi = random.randint(1,100)-1
    voyagesdates[navi].append((start_date,end_date))
    voyagestype.append(type)
    voyagesnavi.append(navi)
    voyagenat.append((portprov,portdest))
    continentvoyage = continents[natprov] if continents[natprov]==continents[natdest] else "Intercontinental"
    voyagewriter.writerow([str(i),start_date,end_date,str(portprov+1),str(portdest+1),str(navi+1),str(distances[portprov][portdest]),continentvoyage])

cargaisons = [[] for i in range(100)]
cargaisonsvoy = []
cargaison = open("cargaison.csv","w",newline='')
cargaisonwriter = csv.writer(cargaison,delimiter=",",quotechar='|',quoting= csv.QUOTE_MINIMAL)
for i in range(1,101):
    voy = i
    cargaisonsvoy.append(voy)
    cargaisonwriter.writerow([str(i),str(voy),str(voyagesnavi[voy-1])])

produit_perissabletype2 = [("Oranges","180"),("Fraises","185"),("Ananas","189"),("Avocat","180")]
produit_perissabletype1 = [("Lait","40"),("Pommes","48"),("Beurre","45")]
produit_sec = [("Sel",""),("Poivre",""),("Sucre",""),("Cafe",""),("Tabac",""),("Rhum",""),("Chandelles",""),("Bois","")]

produit = open("produit.csv","w",newline='')
produitwriter = csv.writer(produit,delimiter=",",quotechar='|',quoting= csv.QUOTE_MINIMAL)
ind = 1
for i in range(1,101):
    maxVol = navirevolume[voyagesnavi[i-1]]
    type = voyagestype[i-1]
    if(type==3):
        while(maxVol!=0):
            givenVol = random.randint(1,int(maxVol))
            product = random.choice(produit_sec)
            valeur_kilo = random.randint(1,21)
            produitwriter.writerow([str(ind),str(i),"",product[0],str(product[1]),str(valeur_kilo),str(givenVol),"true"])
            cargaisons[i-1].append([product[0],product[1],givenVol])
            maxVol -= givenVol
            ind += 1
    elif(type==2):
        while(maxVol!=0):
            givenVol = random.randint(1,int(maxVol))
            product = random.choice(produit_sec+produit_perissabletype2)
            valeur_kilo = random.randint(1,21)
            produitwriter.writerow([str(ind),str(i),"",product[0],str(product[1]),str(valeur_kilo),str(givenVol),"true"])
            cargaisons[i-1].append([product[0],product[1],givenVol])
            maxVol -= givenVol
            ind += 1
    else:
        while(maxVol!=0):
            givenVol = random.randint(1,int(maxVol))
            product = random.choice(produit_perissabletype1+produit_perissabletype2+produit_sec)
            valeur_kilo = random.randint(1,21)
            produitwriter.writerow([str(ind),str(i),"",product[0],str(product[1]),str(valeur_kilo),str(givenVol),"true"])
            cargaisons[i-1].append([product[0],product[1],givenVol])
            maxVol -= givenVol
            ind += 1

inde = 1
etape = open("etape.csv","w",newline='')
etapevoy = []
etapewriter = csv.writer(etape,delimiter=",",quotechar='|',quoting= csv.QUOTE_MINIMAL)
for i in range(1,101):
    if(voyagestype[i-1]==3):
        maxi = random.randint(1,3)
        j = 1
        portprov,portdest = voyagenat[i-1]
        etapevoy.append(i)
        cur = portprov
        while(j<maxi+1):
            for k in range(80):
                if(relationvoyage[portnat[cur]-1][portnat[k]-1]=="en guerre"):
                    continue
                elif(j<maxi+1 and distances[portprov][portdest]//(maxi+1)-500<distances[cur][k]<distances[portprov][portdest]//(maxi+1)+500):
                    passager = navirepassager[voyagesnavi[i-1]]
                    nbdesc = random.randint(0,passager)
                    passager -= nbdesc
                    nbmont = random.randint(0,nbdesc)
                    passager += nbmont
                    etapewriter.writerow([str(inde),str(i),str(portnat[k]),str(nbdesc),str(nbmont),str(j)])
                    cur = k
                    inde += 1
                    j+=1
                elif(distances[cur][k]==0 and cur!=k and j<maxi+1):
                    passager = navirepassager[voyagesnavi[i-1]]
                    nbdesc = random.randint(0,passager)
                    passager -= nbdesc
                    nbmont = random.randint(0,nbdesc)
                    passager += nbmont
                    etapewriter.writerow([str(inde),str(i),str(portnat[k]),str(nbdesc),str(nbmont),str(j)])
                    cur = k
                    distances[cur][k] = random.randint(distances[portprov][portdest]//(maxi+1)-500,distances[portprov][portdest]//(maxi+1)+500)
                    distances[k][cur] = distances[cur][k]
                    inde += 1
                    j+=1
                if(j==maxi):
                    break
            if(j==maxi):
                break
