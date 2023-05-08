INCLUDE globals.ink
VAR Cost = 0
VAR introduced = false
VAR drunken = 0

{intro == "end": -> itemcheck | -> returntoali}

===main===
#portrait:Jack
Hello. I am looking for Ambergris rocks. Is this the right place?#speaker:Etzio
~ drunken = RANDOM(0,3)
{drunken>1: Helo sir, My name is Jck, Why did I say that ? My name is Jack HAHAHA you need what? AMBERGRIS, YES INDEED LET ME CHECK IN THE BACK |Hello{introduced: Welcome Back | My name is Jack}. You have come to the right place my friend. Lets go see if I got any Ambergris in back} #speaker:Jack

VAR rand = 1
~ rand = RANDOM(0,10)

{ rand == 10:
    -> marinesponge
  - else:
    -> ambergris
}


===ambergris===

{drunken>1: I DONT THINK WE HAVE THEM, OHH WAIT! FOUND'EM. We do have them, how many can you afford ? Cost ya 6 per rock | Good news! We do have Ambergris available. It costs 7.5 coins per rock of Ambergris}. #speaker:Jack

Let me have.... #speaker:Etzio
-
+[2 Rocks]->Rockcost(2)
+[1 Rocks]->Rockcost(1)
+[3 Rocks]->Rockcost(3)

===Rockcost(number)===
{drunken > 1:
    ~Cost = 6 * number
-else:
    ~Cost = 7.5 * number
}
~ item2quantity = number
The total cost is {Cost} #speaker:Jack
-
*{playercoins > Cost}[Money - Pay the shopkeeper] -> Money("ambergris",number)
*[Haggle - Reduce the price] -> Haggle("ambergris",number)
*[Ask for alternative] -> alternate_rock(number)

===marinesponge===
{drunken > 1: Ahh, I see W're All Oot, we got Demitrus, Scrillions, Marinesponge. Marine Sponge! that should do the trick here how many ya'eed ?| Unfortunately, we're out of Ambergris rocks since lately they have been hard to procure. But we do have an alternative rocks called Marine Sponge. It costs the same and should get the job done.}#speaker:Jack
{drunken > 1: Gonna Cost ya 5| Gonna Cost ya 7}#speaker:Jack
->TakeMarinesponge

===alternate_rock(number)===
{drunken > 1: Nah we aint got any alternative,this is about it | Yeah, I think the Marinesponge rocks should do the trick}
-
*[Take Ambergris]->Rockcost(number)
*{drunken<2}[Take Marine Sponge]->TakeMarinesponge

===TakeMarinesponge===
Oh, I see. Since there is no other choice #speaker:Etzio
Let me have.... #speaker:Etzio
-
+[2 Rocks]->ARockcost(2)
+[1 Rocks]->ARockcost(1)
+[3 Rocks]->ARockcost(3)

===ARockcost(number)===
{drunken > 1:
    ~Cost = 5 * number
-else:
    ~Cost = 7 * number
}
~ item2quantity = number
The total cost is {Cost} #speaker:Jack
-
*{playercoins > Cost}[Money - Pay the shopkeeper] -> Money("ambergris",number)
*[Haggle - Reduce the price] -> Haggle("ambergris",number)


===Money(item,number)===
That seems like a reasonable price. I'll take {number} rocks. Here's {Cost} coins #speaker:Etzio

{drunken > 1:THANKS,OFF YOU GO! | Thank you. Here are your {item} rocks. If you're ever in need of any kind of rocks, I'm your guy!} #speaker:Jack
~playercoins = playercoins - Cost
-
*[{item} - Take the {number} rocks from the shopkeeper's hand]
-> gratitude(item)

===Haggle(item,number)===
I feel that the price is a bit on the higher side. Can you offer me a better price? #speaker:Etzio
~ Cost = Cost - 2*number
{drunken > 1:->alternate_end_rock(item)|Sir, these rocks are extremely rare and take a lot of effort on my end to find them. The best I can offer you is {Cost} coins.}#speaker:Jack
->Money(item,number) 

===alternate_end_rock(item)==
WE DONT DO DISCOUNTS HERE, BUGGER OFF COME BACK WHEN YOU HAVE MONEY.
~item2quantity = 0 
~item2 = "xyz"
->END

===gratitude(item)===
~ item2 = item
Thank you for your service and {item2} Rocks! #speaker:Etzio

-> END

===itemcheck===

{item2 == "": -> main | -> alreadychoose}

===alreadychoose===
#portrait:Jack
{item2 == "xyz": ->itemaint}
You have already bought {item2}. Anything else I can help you with ?  #speaker:Jack
Not really, Thank you so much #speaker:Etzio 
No Problem, If you need anything let me know #speaker:Jack
-> END

===itemaint===
SORRY, I AIN'T SERVIVING YOU #speaker:Jack #portrait:Jack
->END

===returntoali===
#portrait:Jack
~ introduced = true
Hello sir, welcome. My name is Jack. I'll be happy to help you, Do you know what you need ?  #speaker:Jack
No - I do not know #speaker:Etzio
Sorry to hear that, please do come again #speaker:Jack
-> END