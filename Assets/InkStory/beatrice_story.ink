INCLUDE globals.ink
#portrait:Beatrice
VAR Cost = 0
VAR introduced = false
VAR generosity = 0
VAR discountnumber = 0

{intro == "end": -> itemcheck | -> returntoali}
===itemcheck===
{item1 == "": -> main | -> alreadychoose}

===main===

Hello. I am looking for Pomander vials. Do you have them?#speaker:Etzio

Hello sir,{introduced:Welcome back|Welcome to my shop. My name is Beatrice}. Let me check the inventory, it'll take just a minute. #speaker:Beatrice

~ generosity = RANDOM(0,10)

{ generosity <=6: 
    ~discountnumber = 5
 - else:
    {generosity > 6 && generosity < 9:
        ~discountnumber = 4
    -else: 
        ~discountnumber = 3
    }
}

VAR rand = 1
~ rand = RANDOM(0,10)

{ rand == 10:
    -> amberysaffron
  - else:
    -> pomander
}

===pomander===

Good news! We do have vials of Pomander. It will cost you 5 coins for a vial of Pomander,{discountnumber<5: I feel {discountnumber == 3: extremely | rather} generous today so it might not cost you that much}. Pomander is one of the best restorative medicine out there when mixed with other herbs it can create a long lasting effect even healing deep cuts to the body. How many do you need?#speaker:Beatrice

That's great. #speaker:Etzio
->TakePomander

===TakePomander===
Let me have......
-
+[5 Vials]-> VialCost(5)
+[4 Vials]-> VialCost(4)
+[3 Vials]-> VialCost(3)

===VialCost(number)===
~ Cost = 5 * number
~ item1quantity = number
The total cost is {Cost} #speaker:Beatrice
{number >= discountnumber: -> reduceprice(number)|->nvm(number)}
===reduceprice(number)===
{ discountnumber == 3:
    ~ Cost = Cost - 2*number
 -else:
    ~ Cost = Cost - 5 
}
As the number of items is bulk order I am giving you a discount so the new total cost is {Cost}
->nvm(number)
===nvm(number)===
-
*{playercoins > Cost}[Money - Pay the shopkeeper] -> Money("pomander",number)
*{discountnumber == 5 && number < discountnumber}[Haggle - Reduce the price] -> Haggle("pomander",number)
*[Ask for alternative] -> alternate_vial(number)

===amberysaffron===
Unfortunately, we just sold our last vial of Pomander this morning. But we do have a similar vial called Ambery Saffron. It costs the same as Pomander and has the similar chemical constitution{discountnumber<5: I feel {discountnumber == 3: extremely | rather} generous today so it might not cost you the same as well}.. #speaker:Beatrice
Since I do not have any other choice I'll take your word. ->TakeAmbery #speaker:Etzio

===alternate_vial(number)===
Sorry, but do you have any alternatives which have the same effect but are cheaper ? #speaker:Etzio
Yes, I do have a vial called Ambery Saffron with similar restorative powers, it is not as strong as Pomander but is easier to use. Unfortunately, Both are really rare and tough to create {discountnumber<5: but there could be a price difference|thus there is no difference in price} #speaker : Beatrice
-
+[Buy Pomander]-> VialCost(number)
+[Buy Ambery]-> TakeAmbery

===TakeAmbery===
Let me have......
-
+[5 Vials]-> AVialCost(5)
+[4 Vials]-> AVialCost(4)
+[3 Vials]-> AVialCost(3)

===AVialCost(number)===
~ Cost = 5 * number
~ item1quantity = number

The total cost is {Cost} #speaker:Beatrice
{number >= discountnumber : -> areduceprice(number)|->anvm(number)}
===areduceprice(number)===
{ discountnumber == 3:
    ~ Cost = Cost - 3*number
 -else:
    ~ Cost = Cost - 5 
}
As the number of items is bulk order I am giving you a discount so the new total cost is {Cost}
->anvm(number)
===anvm(number)===
-
*{playercoins > Cost}[Money - Pay the shopkeeper] -> Money("amberysaffron",number)
*{discountnumber == 5 && number < discountnumber}[Haggle - Reduce the price] -> Haggle("amberysaffron",number)

===Money(item,number)===
There, {Cost} coins. #speaker:Etzio
~playercoins = playercoins - Cost
Thank you. Here are your {number} vials of {item}. Do visit again! #speaker:Beatrice

-
*[{item} - Take the {number} vials from the shopkeeper's hand]

-> thanks(item)

===Haggle(item,number)===
I feel that the price is a bit on the higher side. Can you offer me a better price? #speaker:Etzio
Sorry Sir, but I only offer discounted rates if the person is ordering in bulk #speaker:Beatrice
Oh, that seems like a fair policy.#speaker:Etzio
->Money(item,number)

===thanks(item)===
~ item1 = item
Thank you for your service and the {item1} vials. #speaker:Etzio
-> END

===alreadychoose===
#portrait:Beatrice
You have already bought {item1}. Anything else I can help you with ? #speaker:Beatrice
Not really, Thank you so much #speaker:Etzio 
No Problem, If you need anything let me know #speaker:Beatrice
-> END


===returntoali===
#portrait:Beatrice
~ introduced = true
Hello sir, welcome. My name is Beatrice. I'll be happy to help you, Do you know what you need ? #speaker:Beatrice
No - I do not know #speaker:Etzio 
Sorry to hear that, please do come again #speaker:Beatrice
-> END
