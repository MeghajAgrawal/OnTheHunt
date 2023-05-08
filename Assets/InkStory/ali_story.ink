INCLUDE globals.ink

{intro == "begin": -> introduction | -> checkcollectitems}

===introduction===
#portrait:Ali
Welcome to the King's Landing, the town of artifact restorers. I am Ali, the town's head restorer. What can I do for you? #speaker:Ali 


Hello Ali. My name is Etzio. I am looking for someone who can help me restore a damaged artifact. #speaker:Etzio

Well, you've certainly come to the right place. The people of this town have been in the restoration industry since the town's inception. I can certainly help you. But first, I need to know what kind of an artifact are you looking to restore? #speaker:Ali 
Here, take a look yourself. I found this map on one of my expeditions. It was lying under a huge boulder, deep inside a cave.  #speaker:Etzio


* [Treasure Map - Show]

From the looks of it, this looks like a rare ancient treasure map. 
I can help you restore this map to its original glory so that you can decipher the details. #speaker:Ali 

But in order to do so, I'll need some raw materials for the restoration process. You will have to travel throughout the town to find them. Are you up for the challenge? 

I'll do everything to help restore this key to treasure. Give me the list and I will be on my way. #speaker:Etzio

-
* [See the Items on the list]
#speaker:Ali
The items are as follows: - 
1. 3 vials of Pomander.
2. 2 small rocks of Ambergris.
3. 1 Wild Poppy flower.
Bring these items to me as soon as you can, and I will restore the map for you.
~ intro = "end"
->END

===checkcollectitems===
#portrait:Ali
{item1 == "" || item2 == "" || item3 == "": -> collectitems | -> ending}


===collectitems===

Bring all 3 items to me as soon as you can, and I will restore the map for you.#portrait:Ali #speaker:Ali
-> END

===ending===
{end == "begin": -> actualending | -> completed}

===actualending===
{item1 == "amberysaffron" || item2 == "marinesponge" || item3 == "windflower": -> alternate_ending}

{item1quantity >= 3 && item2quantity >= 2 && item3quantity >= 1 : -> giveitemstoali | -> losecondition}
    
===giveitemstoali===
Did you manage to find all the materials on the list?#portrait:Ali #speaker:Ali 

Yes. This bag contains all the raw materials you needed. #speaker:Etzio

{item1 == "pomander" && item2 == "ambergris" && item3 == "wildpoppy":
    *[Items - Give them to Ali] -> fix
    }

===fix===

Great! I have everything I need. I'll get started with the restoration process. Come back again in 30 minutes and your map will be back to its original glory. #speaker:Ali 

-
*[Wait for half an hour]

Is it done? #speaker:Etzio

Yes, sir. Here is your map, as good as it once was. #speaker:Ali 

~ WinCondition = "Vatican"
->credit

===alternate_ending===

I travelled throughout the town, but I couldn't find the exact items that you wanted. I have managed to bring some replacements for them. The vendors told me that this should do the trick.#portrait:Ali #speaker:Etzio

Will this be enough?

Show me the items you have procured. I will take a look at them and determine if I can work with them or not. #speaker:Ali 

-
*[Show them to Ali]

Huh. I think I can make it work with these. Let me have them.

-
*[Give them to Ali]

I'll get started with the restoration process. Come back again in 30 minutes and your map will be back to its original glory. 

-
*[Wait for half an hour]

Is my map restored? #speaker:Etzio

Yes, sir. Here is your map, as good as it once was. #speaker:Ali 

~ WinCondition = "Sistine"
-> credit

===credit===

Thank you for your help. This map is finally readable. How much should I pay you for your services? #speaker:Etzio

You are welcome, sir. My restoration charges are 35 coins. #speaker:Ali 

{playercoins>40: Of course, it's my pleasure. Here's an extra 5 for all your efforts and for doing what no one else could do.|Of course, it's my pleasure.} #speaker:Etzio

-
*{playercoins>35}[Money - Pay the merchant]->Money
*{playercoins<35}[Not Enough]->CantPay
===Money===
{playercoins > 35:
    ~playercoins = playercoins - 40
-else:
    ~playercoins = playercoins - 35
}
Here is the money. #speaker:Etzio
->MapRecieve

===MapRecieve===
Here is the Map. #speaker:Ali
-
*[Treasure Map - Take the map from the merchant's hand.]

Oh. So this is what it really was, a map of an old and secret vault inside the {WinCondition == "Vatican": Vatican Library | Sistine Chapel} . I have heard it contains many secrets of the 15th century. #speaker:Etzio
Thank you, sir. You are welcome to come to our town again, in case you need to restore some other artifact. #speaker:Ali 
I will definitely do that. Thank you! Have a good day sir. #speaker:Etzio

~ end = "end"

->END
===CantPay===
Sorry Sir, without the money, I cannot hand you the map, I will hold on it while you can procure the funds. #speaker:Ali
~WinCondition = "LostGame"
~ end = "end"
->END

===losecondition===
Did you manage to find all the materials on the list? #portrait:Ali #speaker:Ali 

No. I could not find all the materials, is the restoration still possible? #speaker:Etzio

Unfortunately, the restoration is not possible #speaker:Ali
~WinCondition = "LostGame"
~ end = "end"
->END

===completed===
Sir, your map is already restored. #speaker:Ali 

->END


