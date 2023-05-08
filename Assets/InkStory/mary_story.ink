INCLUDE globals.ink

VAR Cost = 0
VAR introduced = false
{intro == "end": -> itemcheck | -> returntoali}
===itemcheck===
{item3 == "": -> main | -> alreadychoose}
===main===
#portrait:Marty
Hello. I am looking for a wild poppy flower. Is that available here? #speaker:Etzio
Hello sir,{introduced:Welcome back.|Welcome. My name is Marty} I'll be happy to help you with that. Let me check our inventory, it'll take just a minute. #speaker:Marty

VAR rand = 1
~ rand = RANDOM(0,10)

{ rand == 10:
    -> windflower
  - else:
    -> wildpoppy
}

===wildpoppy===
Yes, we do have wild poppy flowers available. However since it is extremely difficult to find it's a little expensive. It'll cost you 10 coins per flower. #speaker:Marty
I understand. #speaker:Etzio 
->TakeWildPoppy

===TakeWildPoppy===
Let me have.... #speaker:Etzio
-
+[2 Flower]->Flowercost(2)
+[1 Flower] ->Flowercost(1)
+[3 Flower]->Flowercost(3)

===Flowercost(number)===
~ Cost = 10 * number
~ item3quantity = number
The total cost is {Cost} #speaker:Marty
-
*{playercoins > Cost}[Money - Pay the shopkeeper] -> Money("wildpoppy")
*[Haggle - Reduce the price] -> Haggle("wildpoppy")
*[Ask for alternative] -> alternate_flower(number)

===windflower===
Unfortunately, we don't have wild poppy in our inventory right now since it does not grow during this season. But we do have a similar flower called Wind Flower which can be used as an alternative for any use. It is also a bit cheaper - 8 coins per flower. #speaker:Marty

I think that should work. I'll take my chances.->Takealternative

===alternate_flower(number)===
Sorry, but do you have any alternatives which have the same effect but are cheaper ? #speaker:Etzio
Yes, I do have a similar flower called Wind Flower which can be used as an alternative to Wild Poppy. It is also a bit cheaper - 8 coins per flower #speaker : Marty
-
+[Buy Wild Poppy]-> Flowercost(number)
+[Buy Wind Flower]-> Takealternative

===Takealternative===
Let me have.... #speaker:Etzio
-
+[2 Flower]-> ATotalCost(2)
+[1 Flower]-> ATotalCost(1)
+[3 Flower]-> ATotalCost(3)

===ATotalCost(number)===
~ Cost = 8 * number
~ item3quantity = number
The total cost is {Cost} #speaker:Marty
-
*{playercoins > Cost}[Money - Pay the shopkeeper] -> Money("windflower")
*[Haggle - Reduce the price] -> Haggle("windflower")

===Money(item)===
Here are your {Cost} coins. #speaker:Etzio

Thank you. Here are the flowers. Have a good day. #speaker:Marty
~playercoins = playercoins - Cost
-
*[{item} - Take the {item} from the shopkeeper's hand]
->appreciation(item)

===Haggle(item)===
I feel that the price is a bit on the higher side. Can you offer me a better price? #speaker:Etzio
~ Cost = Cost - 2
Sir, these flowers are rare to find and having them in our shop is rather difficult. The best I can offer you is {Cost}.#speaker:Marty

Understandable. #speaker:Etzio
*{playercoins > Cost}[Money - Pay the shopkeeper] -> Money(item)
*[Haggle - Reduce the price] -> Hagglemore(item)

===Hagglemore(item)===
~ Cost = Cost - 2
But I still dont have enough can you do {Cost}? #speaker:Etzio
{item == "wildpoppy": ->switch | ->Yes}

===switch===
No I cannot, please leave my shop.I do not wish to sell anything to you #speaker:Marty
~item3quantity = 0
~item3 = "xyz"
->END

===Yes===
Yes, It's a bit steep for me but I can. #speaker:Marty
~playercoins = playercoins - Cost
->appreciation("windflower")

===appreciation(item)===
~item3 = item
Thank you for your service and {item3}! #speaker:Etzio

-> END

===alreadychoose===
#portrait:Marty
{item3 == "xyz": -> itemaint}
You have already bought {item3}. Anything else I can help you with ? #speaker:Marty
Not really, Thank you so much #speaker:Etzio 
No Problem, If you need anything let me know #speaker:Marty
-> END
===itemaint===
Sorry, I am not servicing you at the moment #speaker:Marty
->END

===returntoali===
#portrait:Marty
~ introduced = true
Hello sir, welcome. My name is Marty. I'll be happy to help you, Do you know what you need ? #speaker:Marty
No - I do not know #speaker:Etzio
Sorry to hear that, please do come again #speaker:Marty
-> END
