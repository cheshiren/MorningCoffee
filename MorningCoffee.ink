//
//Десмод
//Стрикс|Неясыть


// -> NEWS54.end
// -> NEWS54.taskforce
// -> top

LIST lang = rus, (eng) // очистить перед релизом

LIST coffeeState = beans_are_ground, ingredients_added, ingredients_mixed, heated_1st_time, boiled_1st_time, heated_2nd_time, boiled_2nd_time, heated_3rd_time,boiled_3rd_time, in_cup, ground_settled, ready
LIST coffeeIngredients = beans, ibrik, water, coffee, sugar, grinder

LIST phoneTalk = greetings, cargo_start, hungary_start, hungary_end, soon_start, soon_end, cargo_end, stuff_start, loaders_start, loaders_end, enforcers_start, enforcers_end, stuff_end, clients_start, clients_end
VAR need_answer = false

LIST tvChannel = music, news

LIST musicPlays = riffs, girl_screams, za_starts, za_cont, za_ends
// смена музыкального фона - каждые 5 ходов:
VAR song = 5

VAR end_1st_part = false

<h2>Выберите язык \| Choose the language</h2>
* [Русский]
	~ lang += rus
* [English]
	~ lang += eng
- #CLEAR

<div class="header"><h1>{lang ? rus:Утренний кофе|Morning Coffee}</h1></div>
{lang ? rus:
	- Я стою на краю обрыва и смотрю на восток, на горизонт, откуда вот-вот покажется солнце. Снимаю мотоциклетный шлем и оскаливаюсь в ухмылке. Ну давай же.
	- I stand on the edge of a cliff and look to the east, waiting for the sun to emerge. I take off the bike helmet and grin. Come on, show yourself.
}
* [>>]
	{lang ? rus:
		- Первые лучи брызжут раскалённым железом. Ослеплённый, я чувствую их пламенные объятия на своей коже. Я хохочу.
		- First rays spray with molten iron. Blinded, I feel their fierce hugs on my skin. I laugh.
	}
	** [>>] 
		{lang ? rus:
			- И просыпаюсь.
			Пару минут лежу, глядя на тёмный потолок, потом подношу к глазам руку с часами: половина седьмого. Пора вставать.
			- And wake up.
			I lie for a couple of minutes looking at the dark ceiling, then glance at the wristwatch: half-past six. Time to rise.
		}
		*** [>>]
			{lang ? rus:
				- Накинув халат, протопав в ванную, проведя все необходимые процедуры, я спускаюсь в холл и оттуда в кухню. Утро должно начинаться с чашки хорошего, крепкого кофе.
				А кофе я пью по-турецки.
				- I wear the bathrobe, step into the bathroom, do all the rituals, then go down in the hall and enter the kitchen. The day should start with a cup of good strong coffee.
				And I prefer the Turkish one.
			}

- (top)
	// [{coffeeState}]
	<- TV
	<- Phone
	<- Coffee.opts
	// <- TV.opts
	<- Phone.opts

== Coffee
= opts
	// {Phone.ring == 4 && Phone.text == 0: -> DONE}
	{need_answer: -> DONE}
	* {coffeeIngredients !? ibrik} [{lang ? rus:Найти турку|Find the ibrik}]
		{lang ? rus:
			- Открыв {kitchen_cupboards(1)} своей хайтековской кухни, достаю оттуда турку. Настоящую, медную. Совсем не подходящую по стилю окружающей мебели. Ставлю её на холодную плиту.
			- I open {kitchen_cupboards(1)} in my hi-tech kitchen and reveal the ibrik. Authentic, made of copper. Doesn't match the overall style at all. I put it on the cold stove.
		}
		~coffeeIngredients += ibrik
	* {coffeeIngredients !? beans} [{lang ? rus:Найти зёрна|Find the beans}]
		{lang ? rus:
			- В {kitchen_cupboards(2)} я нахожу джутовый мешочек с трафаретной надписью «Cafés do Brasil» и ставлю {coffeeIngredients !? grinder:на стойку|рядом с мельницей}.
			- Inside {kitchen_cupboards(1)}, I find a little jute bag with the stencil "Cafés do Brasil" and put it {coffeeIngredients !? grinder:on the counter|next to the grinder}.
		}
		~coffeeIngredients += beans
	* {coffeeIngredients !? grinder} [{lang ? rus:Найти мельницу|Find the grinder}]
		{lang ? rus:
			- Из {kitchen_cupboards(3)} я осторожно вынимаю ручную мельницу и выставляю {coffeeIngredients !? beans:на стойку|рядом с зёрнами}. Немецкий антиквариат времён кайзера. На белой эмали, покрытой паутиной трещин, — чёрные готические буквы: «Kaffee».
			- From {kitchen_cupboards(1)}, I take out the hand grinder and stand it {coffeeIngredients !? beans:on the counter|next to the beans}. German antiques of Kaiser times. White enamel is covered with a web of tiny cracks and bears the black gothic letters: "Kaffee".
		}
		~coffeeIngredients += grinder
	* {coffeeState < beans_are_ground && coffeeIngredients ? beans && coffeeIngredients ? grinder} [{lang ? rus:Смолоть зёрна|Grind the beans}]
		{lang ? rus:
			- Развязываю мешочек, пахну́вший жареным кофе, набираю полную пригоршню и ссыпаю в чашу на мельнице. Не торопясь, кручу ручку, слушая хруст зёрен.
			- I untie the bag smelling of roasted coffee, take the handful of beans, and pour them into the grinder's bowl. Then keep turning the handle and listen to the beans crunching.
		}// Когда чаша пустеет, выдвигаю ёмкость снизу, пересыпаю её содержимое назад в чашу и снова кручу ручку. Повторяю несколько раз, пока не получаю очень тонкий помол.
		~coffeeState -= coffeeState
		~coffeeState += beans_are_ground
	* {coffeeIngredients !? coffee && coffeeIngredients ? ibrik && coffeeState == beans_are_ground} [{lang ? rus:Насыпать смолотый кофе|Pour the ground coffee}]
		{lang ? rus:
			- Набираю полную столовую ложку молотого кофе и задумываюсь: не мало?
			- I take a tablespoon of ground coffee and think again: is it enough?
		}
		** [{lang ? rus:Хватит и ложки|The tablespoon is enough}]
			{lang ? rus:
				- Решаю, что с таким тонким помолом кофе получится достаточно крепким,
				- I decide that ground is fine enough
			}
		** (dark_coffee)[{lang ? rus:Набрать ложку с горкой|Take a heaped tablespoon}]
			{lang ? rus:
				- Решаю, что как раз сейчас мне не помешает дополнительный заряд бодрости, добираю кофе с горкой,
				- I decide that I need an additional charge right now, take a heaped tablespoon of coffee
			}
		--	<> {lang ? rus:
					- и ссыпаю его в турку.
					- and pour it into the ibrik.
				}
			~coffeeIngredients += coffee
	* {coffeeIngredients !? sugar && coffeeIngredients ? ibrik} [{lang ? rus:Насыпать сахар|Pour some sugar}]
		{lang ? rus:
			- Придвинув хромированную сахарницу, задумываюсь, какой кофе мне сейчас хочется?
			- Reaching for the chromium-plated sugar bowl, I think again, what kind of coffee do I want right now?
		}
		** (az_sekerli) [{lang ? rus:Az Şekerli (меньше чайной ложки сахара)|Az Şekerli (less than a teaspoon of sugar)}]
		** (orta_sekerli) [{lang ? rus:Orta Şekerli (с парой чайных ложек)|Orta Şekerli (with a couple of sugar teaspoons)}]
		** (sekerli) [{lang ? rus:Şekerli (с тремя чайными ложками)|Şekerli (with three teaspoons of sugar)}]
		--	{lang ? rus:
				- Насыпаю желаемое количество белого песка в турку.
				- I pour the desired amount of white sand into the ibrik.
			}
			~coffeeIngredients += sugar
	* {coffeeIngredients !? water && coffeeIngredients ? ibrik} [{lang ? rus:Налить в турку воды|Pour water in the ibrik}]
		{lang ? rus:
			- Наполняю турку до половины водой из фильтра.
			- I fill the ibrik with water from the filter.
		}
		~coffeeIngredients += water
	* {coffeeState == ingredients_added} [{lang ? rus:Перемешать содержимое турки|Stir the ibrik's contents}]
		{lang ? rus:
			- Тщательно перемешиваю воду, кофе и сахар, пока не получаю однородную взвесь.
			- I stir water, coffee, and sugar until I have them thoroughly mixed.
		}
		~coffeeState -= coffeeState
		~coffeeState += ingredients_mixed
	* (heat1) {coffeeState == ingredients_mixed} [{lang ? rus:Поставить турку на медленный огонь|Put the ibrik on medium heat}]
		{lang ? rus:
			- Щёлкнув пару раз ручкой плиты, ставлю турку прямо на центр конфорки.
			- I click an oven handle a couple of times and put the ibrik in the center of a hotplate.
		}
		~coffeeState -= coffeeState
		~coffeeState += heated_1st_time
	+ {coffeeState == heated_1st_time || coffeeState == heated_2nd_time || coffeeState == heated_3rd_time} [{lang ? rus:Ждать, пока готовится кофе|Wait for the coffee to boil}]
	* (heat2) {coffeeState == boiled_1st_time} [{lang ? rus:Снять турку с огня|Remove the ibrik from heat}]
		{lang ? rus:
			- По кухне уже разносится аромат {dark_coffee: крепкого }кофе. Убираю турку с плиты и ложкой снимаю всю пену в чашку. Ставлю турку назад на конфорку.
			- The smell of {dark_coffee: strong }coffee carries all over the kitchen. I remove the ibrik from the oven and use a spoon to pour all of the foam into a cup. Return the ibrik on the hotplate.
		}
		~coffeeState -= coffeeState
		~coffeeState += heated_2nd_time
	* (heat3) {coffeeState == boiled_2nd_time} [{lang ? rus:Ещё раз снять турку с огня|Remove the ibrik from heat again}]
		{lang ? rus:
			- Во второй раз снимаю турку с плиты и тонкой струйкой выливаю половину кофе в чашку.
				Возвращаю турку на конфорку.
			- I remove the ibrik from the oven for the second time and pour half of the coffee into the cup.
				I put the ibrik back.
		}
		~coffeeState -= coffeeState
		~coffeeState += heated_3rd_time
	* {coffeeState == boiled_3rd_time} [{lang ? rus:Окончательно снять турку с огня|Remove the ibrik completely}]
		~coffeeState -= coffeeState
		~coffeeState += in_cup
		{lang ? rus:
			- Выключаю плиту, в последний раз снимаю турку и аккуратно выливаю оставшуюся половину кофе в чашку, стараясь не слить кофейную гущу из турки.
			- I turn off the oven, remove the ibrik from it and cautiously pour the remaining half of the coffee into the cup, trying not to pour the dregs.
		}
	* {coffeeState == in_cup} [{lang ? rus:Подождать, пока в чашке опустится осадок|Wait for grounds to settle}]
		~ coffeeState++
		{lang ? rus:
			- Пока кофе в чашке «доходит», я убираю назад всё, что доставал из шкафов, вытряхиваю и ополаскиваю турку. Остался последний штрих.
			- While the coffee is "cleansing" I put back everything I took from the cupboards, clean and wash the ibrik. One final step is left.
		}
	* {coffeeState == ground_settled} [{lang ? rus:Добавить в кофе немного «приправы»|Add some "condiment"}]
		~ coffeeState++
		{lang ? rus:
			- Открываю холодильник, достаю пакет багряной жидкости и несколько раз встряхиваю.
			- I open the fridge, take out the package of scarlet liquid and shake it several times.
		}
			** [{lang ? rus:Добавить одну каплю|Add one drop}]
				{lang ? rus:
					- Задумываюсь, когда в последний раз пил кофе со свежей «приправой», без антикоагулянта. Но тут же отгоняю мрачные мысли и выдавливаю одну каплю в чашку.
					- I try to remember the last time I had a coffee with a fresh "condiment", without the taste of anticoagulant. But then I brush gloomy thoughts away and squeeze a drop into the cup.
				}
			** [{lang ? rus:Добавить несколько капель|Add several drops}]
				{lang ? rus:
					- Возможно, появится привкус антикоагулянта, но хочется себя побаловать. Выдавливаю несколько капель в чашку.
					- The taste of anticoagulants will emerge for sure, but I want to treat myself. I squeeze several drops into the cup.
				}
			--	<> {lang ? rus:
						- Убираю пакет.
							Кофе готов.
						- I put the package away.
							The coffee is ready.
					}
	+ {coffeeState == ready && !end_1st_part} [{lang ? rus:Пить кофе|Drink coffee}]
		{ stopping:
			- {lang ? rus:
				- Я двумя пальцами подношу чашку к губам и, вдыхая аромат, делаю первый, самый важный глоток.
				- I take the cup with two fingers, smell the aroma and make the first, most important sip.
			}
			{
				- az_sekerli: {lang ? rus:Чистая|Clear}
				- orta_sekerli: {lang ? rus:Подслащённая|Sweetened}
				- sekerli: {lang ? rus:Сладкая|Sweet}
			}
			<>{lang ? rus:
				- {dark_coffee:, терпкая} горечь мгновенно отбирает на себя всё внимание чувств, ослепительной вспышкой перегружает сенсорику. Медный привкус «приправы» оттеняет эту горечь и добавляет нотку особого томления, мало кому знакомого. # CLASS: coffee
				Да, отличный вышел кофе.
				- {dark_coffee:, strong} bitterness grabs all the attention, overloads the senses with a blinding flash. The coppery flavor of the "condiment" accentuates the bitterness and adds this note of special yearning, known to a few. # CLASS: coffee
				Yep, the coffee is great.
			}
			- {lang ? rus:
				- Я встаю у окна и пью кофе маленькими глотками, наслаждаясь и глядя на огни ночного города.
				- I go to the window, enjoy little sips of the coffee, and overwatch the lights of the night city.
			}
			- {lang ? rus:
				- Я наслаждаюсь своим кофе, глядя в окно, когда Десмод вдруг замолкает.
				- I enjoy my coffee and look out the window when Desmod falls silent.
			}
				~ end_1st_part = true
				{lang ? rus:
					- ** — Десмод?
						-> NEWS54
					- ** "Desmod?"
						-> NEWS54
				}
		}
	- 
	// если все игредиенты собраны — статус кофе меняется
	{
		- coffeeIngredients ? (water, sugar, coffee) && coffeeState < ingredients_added:
			~coffeeState -= coffeeState
			~coffeeState += ingredients_added
	}
	// если после начала 1-го нагрева прошло 2 хода — кофе вскипятился 1-ый раз
	{
		- TURNS_SINCE(-> heat1) > 0 && coffeeState < boiled_1st_time:
			~coffeeState -= coffeeState
			~coffeeState += boiled_1st_time
	}
	// если после начала 2-го нагрева прошло 2 хода — кофе вскипятился 2-ой раз
	{
		- TURNS_SINCE(-> heat2) > 0 && coffeeState < boiled_2nd_time:
			~coffeeState -= coffeeState
			~coffeeState += boiled_2nd_time
	}
	// если после начала 3-го нагрева прошло 2 хода — кофе вскипятился 3-ий раз
	{
		- TURNS_SINCE(-> heat3) > 0 && coffeeState < boiled_3rd_time:
			~coffeeState -= coffeeState
			~coffeeState += boiled_3rd_time
	}

	-> top



== TV
	{LIST_COUNT(coffeeIngredients) <= 2: -> DONE | -> text}
= text
	{
		- text == 1:
			~ tvChannel += music
			~ musicPlays += riffs
			{lang ? rus:
				- Мимоходом клацаю лежащий тут же пульт от телевизионной панели за спиной. <span class="tv">Всё свободное пространство заполняется звуками мрачных гитарных риффов.</span>
				- I passingly click the remote control of the TV panel in the hall. <span class="tv">All of the space fills with grim sounds of guitar riffs.</span>
			}
	}
	{
		- tvChannel ? music:
			-> Music.back ->
		- tvChannel ? news:
			-> News.back ->
	}
-> DONE
= opts
	{text < 1 or need_answer: -> DONE}
	+ [Переключить тв-канал]
		~ tvChannel = LIST_INVERT(tvChannel)
		Не глядя переключаю телевизор на {tvChannel ? music:музыкальный|новостной} канал. <>
		{
			- tvChannel ? music:
				-> Music.turn ->
			- tvChannel ? news:
				-> News.turn ->
		}
	- -> top

== Music
= back
	// [{Music}][{musicPlays}]
	{ Music % song == 0:
		~ musicPlays++
	}
	{
		- Music % song == 0:
			{
				- musicPlays ? girl_screams:
					{lang ? rus:
						- От телевизионной панели слышно, как к гитарам присоединяется женский вокал и, срываясь на визг, начинает кричать о «сёстрах на кострах». # CLASS: tv
						- From the TV panel, I hear as the woman voice accompanies the guitars and starts screaming about "sisters burned on the stakes." # CLASS: tv
					}
				- musicPlays ? za_starts:
					{lang ? rus:
						- Песня, гремящая по телевизору, стихает на одном протяжном риффе и через несколько секунд тишины начинается другая. # CLASS: tv
						- The thundering song of TV ends with the particularly long riff and after several silent seconds, another one starts. # CLASS: tv
					}
				- musicPlays ? za_cont:
					{lang ? rus:
						- От телевизионной панели слышно, как то, что поначалу показалось госпелом, превращается во что-то по-настоящему тёмное и мрачное. # CLASS: tv
						- From the TV panel, I hear what sounded like Gospel turns into something dark and macabre. # CLASS: tv
					}
				- musicPlays ? za_ends:
					{lang ? rus:
						- «Псевдо-госпел» завершается сходящим на нет скримом вокалиста. Неплохо. # CLASS: tv
						- Pseudo-Gospel ends with the winding-off scream of the singer. Not bad. # CLASS: tv
					}
			}
		- Music % song == 1:
			{
				- musicPlays ? za_starts:
					{lang ? rus:
						- Я вдруг понимаю, что мелодия и вокал новой песни слишком похожи на госпел. Уже тянусь к пульту, когда первые же строчки развеивают мои опасения. # CLASS: tv
						- I suddenly realize that melody and voice of the new song are resemble Gospel too much. I am reaching the remote when the first lines of lyrics dispel my concerns. # CLASS: tv
					}
			}
	}
->->
= turn
	{
		- musicPlays ? riffs:
			<span class="tv">Там всё так же гремят гитарные риффы.</span>
		- musicPlays ? girl_screams:
			{
				- Music % song == 0:
					<span class="tv">В комнату врывается женский вокал, который кричит про «сестёр на кострах».</span>
				- else:
					<span class="tv">Вокалистка всё так же надрывается про «сестёр на кострах».</span>
			}
		- musicPlays ? za_starts:
			{
				- Music % song == 0:
					<span class="tv">Спиричуэлс?</span>
				- else:
					<span class="tv">Всё ещё спиричуэлс.</span>
			}
			
	}
->->

== News
= turn
	<span class="tv">только переключился на новости</span>
->->
= back
	<span class="tv">давно на новостном</span>
->->


== Phone
	{LIST_COUNT(coffeeIngredients) <= 4: -> DONE}
	{phoneTalk !? greetings: <- ring | <- text}
= ring
	{
		- ring == 1:
			{lang ? rus:
				- Чёрный прямоугольник телефона издаёт мелодичную трель и просыпается с именем на весь экран: «Десмод».
				- The black rectangle of the phone rings and wakes up with the name: "Desmod."
			}
		- ring == 2:
			{lang ? rus:
				- Телефон продолжает звонить.
				- The phone keeps ringing.
			}
		- ring == 3:
			{lang ? rus:
				- Телефон всё звонит.
				- The phone is still ringing.
			}
		- ring == 4:
			{lang ? rus:
				- От телефона раздаётся сигнал включения автоответчика и доносится голос помощника:
				— Хефе, это Десмод. Как договаривались, звоню с отчётом. # CLASS: voice
				Я подхватываю наушник гарнитуры, вставляю в ухо и жму кнопку приёма:
				- The phone blips with the answering machine sound and I hear the assistant's voice:
				"Jefe, Desmod speaks. I am calling with the report, as you ordered." # CLASS: voice
				I grab the hands-free earplug, insert it and press to answer:
			}
			<- talk
	}
= text
	{	
		
		- phoneTalk ? soon_start && phoneTalk !? soon_end:
		{ once:
			- 
			- {lang ? rus:
				- Из наушника доносится голос Десмода\:
					— …Сможем отвезти заказ на Холмы, семье Алистера… # CLASS: voice
				- The voice of Desmod is heard from the earplug\:
					"Will be able to deliver the order to the Hills, for the Alisters…"	 # CLASS: voice
			}
			- {lang ? rus:
				- — …Потом Северо-Запад, Эмбаркадеро, Промзона… # CLASS: voice
				- "…North-West then, Embarcadero, Industrial district…" # CLASS: voice
			}
			- {lang ? rus:
				- — …Подключим ещё ребят и да, думаю, управимся раньше. # CLASS: voice
				- "…Will call more guys and, yes, I think we'll make it earlier." # CLASS: voice
			}
			~ phoneTalk += soon_end
			{ phoneTalk ? hungary_end:
				{lang ? rus:
					- <> У меня по грузу вся информация, хефе. Что-нибудь ещё?
					- "That's all I have about cargo, Jefe. Anything else?" # CLASS: voice
				}
				~ phoneTalk += cargo_end
			}
			<- talk
		}
		- phoneTalk ? hungary_start && phoneTalk !? hungary_end:
		{ once:
			- 
			~ phoneTalk += hungary_end
			{ phoneTalk ? soon_end:
				~ phoneTalk += cargo_end
			}
			<- talk
		}
		- phoneTalk ? cargo_start && phoneTalk !? cargo_end:
		{ once:
			- 
			- {lang ? rus:
				- Десмод продолжает докладывать в наушник\:
					— …Перевезли всё несколькими рейсами на фабрику, разгрузили в дальних складах… # CLASS: voice
				- Desmod continues his report:
					"…We've moved the cargo to the factory in several runs, unloaded it in far warehouses…" # CLASS: voice
			}
			-	{lang ? rus:
				- — …Сейчас парни делят груз на партии, в течение суток сможем начать развозить по клиентам. # CLASS: voice
				- "…Guys are dividing the cargo into batches right now. Will be able to deliver to clients in twenty-four." # CLASS: voice
			}
			// ~ phoneTalk += cargo_end
			<- talk
		}
		- phoneTalk ? loaders_start && phoneTalk !? loaders_end:
		{ once:
			- 
			~ phoneTalk += loaders_end
			{ phoneTalk ? enforcers_end:
				~ phoneTalk += stuff_end
			}
			<- talk
		}
		- phoneTalk ? enforcers_start && phoneTalk !? enforcers_end:
		{ once:
			- 
			- {lang ? rus:
				- — …В машинах сопровождения по наблюдателю и два оператора… # CLASS: voice
				- "…There are an observer and two operators in each of the escort cars…" # CLASS: voice
			}
			- {lang ? rus:
				- — …В случае чего, на связи всегда отдельная группа поддержки… # CLASS: voice
				- "…Just in case, there is a support squad always on air…" # CLASS: voice
			}
			- {lang ? rus:
				- — …Но никаких эксцессов не ожидаем. В последнее время всё тихо. # CLASS: voice
				- "…But we don't foresee any incidents. It's quiet lately." # CLASS: voice
			}
			~ phoneTalk += enforcers_end
			{ phoneTalk ? loaders_end:
				{lang ? rus:
					- <> У меня по штату всё. Что-то ещё, хефе?
					- "That is all I have on stuff. Anything else, Jefe?" # CLASS: voice
				}
				~ phoneTalk += stuff_end
			}
			<- talk
		}
		- phoneTalk ? stuff_start && phoneTalk !? stuff_end:
		{ once:
			- 
			- {lang ? rus:
				- Десмод продолжает докладывать в наушник\:
					— …Шестеро водителей, сейчас все на линии. У каждого по рейсу, потом возвращаются на базу. # CLASS: voice
				- Desmod continues to report in the earplug\:
					"…Six drivers on the line. Each has a run, then returns to the base." # CLASS: voice
			}
			// ~ phoneTalk += stuff_end
			<- talk
		}
		- phoneTalk ? clients_start && phoneTalk !? clients_end && !end_1st_part:
		{ once:
			- 
			- {lang ? rus:
				- — …Новичкам из пригорода отвезли семь объёмов, они явно расширяются, нужно взять на заметку… # CLASS: voice
				- "…Newbies from suburbs have gotten seven volumes, it seems they are expanding, should keep an eye on them…" # CLASS: voice
			}
			- {lang ? rus:
				- — …Марку Питбулю доставили новый объём бесплатно, прошлый заказ и правда оказался некачественным — поставщик разбавил местной глиной, с ним уже разобрались… # CLASS: voice
				- "…Mark Pitbull was provided with the new volume for free, the last delivery turned out to be of poor quality — the supplier has diluted it with local loam. He's been dealt with…" # CLASS: voice
			}
			- {lang ? rus:
				- — …По отработанным заказам всё. На сегодня у нас новая партия. Как я говорил, сначала доставляем старику Алистеру и его выводку на Холмы — шесть объёмов… # CLASS: voice
				- "…That's all for closed orders. Now for today's fresh routes. As I said, we deliver to the old Alister and his brood on the Hills first — six volumes…" # CLASS: voice
			}
			- {lang ? rus:
				- — …Клиенты из Северо-Запада покупают редко и немного, но платят всегда хорошо и в срок. На сегодня закзали два объёма… # CLASS: voice
				- "…Clients from North-West buy seldom and small but pay well and on time. Have ordered two volumes for today…" # CLASS: voice
			}
			- {lang ? rus:
				- — …Дальше тот хлыщ из Эмбаркадеро. Своего ковена не заводит, но объём обновляет регулярно, поэтому предпоследний рейс к нему… # CLASS: voice
				- "…Then this fop from Embarcadero. Doesn't make his own coven but refreshes the volume regularly. The second to the last run is his…" # CLASS: voice
			}
			- {lang ? rus:
				- — … # CLASS: voice
				- "…" # CLASS: voice
			}
			// ~ phoneTalk += stuff_end
			<- talk
		}
	}
-> DONE

= opts
	{LIST_COUNT(coffeeIngredients) <= 4: -> DONE}
	* {ring < 3 && phoneTalk !? greetings} [{lang ? rus:Ответить на звонок|Answer the phone}]
	* {ring >= 3 && phoneTalk !? greetings} [{lang ? rus:Всё таки ответить на звонок|Answer this phone}]
	- (took)
		{lang ? rus:
			- Я подхватываю наушник гарнитуры, вставляю в ухо и жму кнопку приёма:
			— Десмод?
			— Хола, хефе. Как договаривались, звоню с отчётом. # CLASS: voice
			- I grab the hands-free earplug, insert it and press to answer:
			"Desmod?"
			"Hola, Jefe. I am calling to report as you ordered." # CLASS: voice
			
		}
		<- talk
= talk
	~ need_answer = true
	~ phoneTalk += greetings
	* {phoneTalk !? cargo_start and !(phoneTalk ? stuff_start && phoneTalk !? stuff_end)}  {lang ? rus:— Рассказывай про груз.|"Tell me about the cargo."}
		{lang ? rus:
			- — Груз прибыл в порт шесть часов назад. Два контейнера, по тридцать кубов каждый… # CLASS: voice
			- "Cargo has arrived in the port six hours ago. Two containers, thirty cubic meters each…" # CLASS: voice
		}
		~ phoneTalk += cargo_start
	* {phoneTalk ? cargo_start && phoneTalk !? cargo_end && phoneTalk !? hungary_start}  {lang ? rus:— Землю-то проверили?|"Have you checked soil?"}
		{lang ? rus:
			- — Да, хефе. Наилучший венгерский чернозём. Стрикс его чуть ли не есть начал, когда вскрыли мешки. # CLASS: voice
				Я оставляю его комментарий без внимания.
				{ phoneTalk ? soon_end:
					— У меня по грузу вся информация. Что-нибудь ещё, хефе? # CLASS: voice
				}
			- "Yes, Jefe. The best Hungarian topsoil. Strix almost started to eat it when we've opened sacks." # CLASS: voice
				I pay no attention to his comment.
				{ phoneTalk ? soon_end:
					"That's all I have about the cargo. Anything else, Jefe?" # CLASS: voice
				}
		}
		~ phoneTalk += hungary_start
	* {phoneTalk ? cargo_start && phoneTalk !? cargo_end && phoneTalk !? soon_start}  {lang ? rus:— Сутки — слишком много. Когда будут готовы первые партии?|"Twenty-four hours is too long. When the first batches will be ready?"}
		{lang ? rus:
			- — Так. Ну первую «Вольво» парни загрузят часа через три, думаю… # CLASS: voice
			- "Well. The first Volvo would be ready in three hours, I think…" # CLASS: voice
		}
		~ phoneTalk += soon_start
	* {phoneTalk !? stuff_start and !(phoneTalk ? cargo_start && phoneTalk !? cargo_end)}  {lang ? rus:— Рассказывай про штат.|"Tell me about the stuff."}
		{lang ? rus:
			- — Сегодня по спискам вышли: двенадцать грузчиков, из них восемь на фабрике, четверо на линии… # CLASS: voice
			- "According to records today we have: twelve loaders, eight are at the factory, four are on the line…" # CLASS: voice
		}
		~ phoneTalk += stuff_start
	* {phoneTalk ? stuff_start && phoneTalk !? stuff_end && phoneTalk !? loaders_start}  {lang ? rus:— {phoneTalk ? enforcers_end: А что, есть|Есть} машины в рейсах без грузчиков?|"There are trucks without loaders?"}
		{lang ? rus:
			- — Да, там небольшие заказы, водители сами справятся. # CLASS: voice
			- "Yeah, those are small orders, drivers will handle themselves." # CLASS: voice
		}
		{ phoneTalk ? enforcers_end:
			{lang ? rus:
				- <> У меня по штату всё. Что-то ещё, хефе? # CLASS: voice
				- "That's all I have on the stuff. Anything else, Jefe?" # CLASS: voice
			}
		}
		~ phoneTalk += loaders_start
	* {phoneTalk ? stuff_start && phoneTalk !? stuff_end && phoneTalk !? enforcers_start}  {lang ? rus:— А что с охраной?|"What about security?"}
		{lang ? rus:
			- — За каждым грузовиком закреплено по машине сопровождения… # CLASS: voice
			- "Every truck is followed by an escort car…" # CLASS: voice
		}
		~ phoneTalk += enforcers_start
	* {phoneTalk ? cargo_end && phoneTalk ? stuff_end && phoneTalk !? clients_start}  {lang ? rus:— Давай пройдёмся по списку клиентов. Кто отработан, кто в очереди и так далее.|"Let's run the clients list. Who is dealt, who is next, etc."}
		{lang ? rus:
			- — Так. Из тех заказов, что запланированны на этой неделе уже доставлены: группе Маддса, что в южных районах — четыре объёма… # CLASS: voice
			- "Sure. With the orders planned for this week next are delivered: Madds’ group in the southern blocks — four volumes…" # CLASS: voice
		}
		~ phoneTalk += clients_start
	-
	~ need_answer = false
	-> top

== NEWS54
{lang ? rus:
	- — Хефе, у вас работает телевизор? Скорее переключитесь на новостной канал! # CLASS: voice
	- "Jefe, do you have the TV turned on? Please, tune to the news!" # CLASS: voice
}
* [{lang ? rus:Переключить канал|Change TV channel}]
-	{lang ? rus:
	- Я подхватываю пульт телевизионной панели и на пути к ней жму цифры новостного канала.
		На экране — ночь, улица в пригороде, двухэтажный белый дом. Вокруг дома — полицейское оцепление. Маячки нескольких машин заливают улицу красным и синим светом. Надпись в углу: «Прямой эфир». # CLASS: tv
		«…продолжается полицейская операция по задержанию опасного преступника. Личность задерживаемого пока не раскрывается, только то, что он как-то связан с известными событиями последних нескольких месяцев: нападением на Тринадцатое полицейское отделение, взрывами на объектах транспортного управления, массовым исчезновением людей…» # CLASS: tv # CLASS: voice
	- I grab the remote and press digits of the news channel while nearing the TV panel.
		On the screen: night, suburban street, two-story white house. House is surrounded by police. The lights of several cars are drowning the street with red and blue flashes. Label in the corner: "Live". # CLASS: tv
		"…police operation to detain a dangerous criminal is continued. The identity of the offender is not revealed, only facts that he is somehow connected to known cases happened within last months: assault on the Thirteen's Police Station, explosions at Transport Department's infrastructure, mass disappearance of people…" # CLASS: tv  # CLASS: voice
}
* [{lang ? rus:Смотреть сюжет|Follow the story}]
-	{lang ? rus:
	- Картинка на экране меняется: репортёр берёт интервью у высокого полицейкого чина. На фоне всё так же мечется красно-синий свет. # CLASS: tv
		«По нашим данным субъект, живущий в этом доме, является главой картеля, занимающегося крупными контрабандными перевозками. Таким образом, он является ключевым звеном в логистике у криминальных организаций, наводнивших наш город в последний год». # CLASS: tv # CLASS: voice
		Голос Десмода в наушнике:
		— Хефе, это же на вашей улице! Разве это не ваш дом!? # CLASS: voice
	- The picture on the screen changes: a reporter is interviewing some police high-rank. The red-blue lights are splashing in the background. # CLASS: tv
		"According to our data, the suspect living in this house is the head of the strong cartel involved in major smuggling. Therefore, he is a key figure in logistics of several criminal organizations flooded our city recently." # CLASS: tv # CLASS: voice
		Desmod in the earplug:
		"Jefe, it is on your street! Isn't this your house?!" # CLASS: voice
}
* [{lang ? rus:Игнорировать Десмода|Ignore Desmod}]
*  {lang ? rus:— Тише, Десмод. Дай посмотреть.|"Hush, Desmod. I'm watching."}
- {lang ? rus:
	- «Простите, но контрабандой чего занимается этот картель?» # CLASS: tv # CLASS: voice
		«Земли». # CLASS: tv # CLASS: voice
		«Земли?» # CLASS: tv # CLASS: voice
		«Да. Земли из Восточной Европы. И перед тем, как вы зададите свой следующий вопрос, я попрошу выступить нашего консультанта от Римской католической церкви. Отец Кобб, будьте добры». # CLASS: tv # CLASS: voice
	- "Excuse me, but what is this cartel smuggling?" # CLASS: tv # CLASS: voice
		"Soil." # CLASS: tv # CLASS: voice
		"Soil?" # CLASS: tv # CLASS: voice
		"Yes. Eastern European soil. And before you ask your next question, please, let me introduce our consultant from the Roman Catholic Church. Father Cobb, would you kindly step in." # CLASS: tv # CLASS: voice
}
* [{lang ? rus:Смотреть дальше|Continue watching}]
-	{lang ? rus:
	- <span class='tv'>На экране появляется хмурый священник в чёрной сутане с неизменной книжкой в руках.</span> Я салютую ему чашкой кофе.
		«Я знаю, что многие из вас не верят. Уже много месяцев правительства твердят об угрозе, но всё это больше похоже на истории из дешёвых романов и посредственного кино. Однако, уверяю вас — угроза вполне реальна. Церковь веками боролась с этой заразой, сдерживала её…» # CLASS: tv # CLASS: voice
	- <span class='tv'>A frowning priest in a black cassock and with the permanent book in his hands appears on the screen.</span> I salute him with the coffee cup.
		"I know that many of you do not believe. For many months, governments have warned over and over of the threat. Which reminds some cheap books or B-movies low-level stories. But you should heed the warnings - the threat is very real. For many centuries The Church fought this plague, kept it off…" # CLASS: tv # CLASS: voice
}
* [{lang ? rus:Фыркнуть|Snort}]
-	{lang ? rus:
	- В этом месте я презрительно фыркаю.
		«…Но современный мир оказался слишком восприимчив к ней. И наш город, как и многие другие в мире, сейчас захлёстывает эпидемия — да-да, именно эпидемия — вампиризма. Чтобы сдержать её, уже недостаточно просто точечного ликвидирования верховного вампира, или упыря, или стригоя. Нужен системный подход…» # CLASS: tv # CLASS: voice
	- At these words, I snort scornfully.
		"…But the modern world has turned out to be too susceptible to it. And our city as many-many others in the world is drowning in an epidemic - yes, the epidemic it is! - of vampirism. This time it is not enough to just eliminate the high vampire, or strigoi, or oupyr to overcome the plague. We need a systematic approach…" # CLASS: tv # CLASS: voice
}
* [{lang ? rus:Слушать священника|Listen to the priest}]
-	{lang ? rus:
	- «…Нужно лишить вампиров одного из средств существования. И если лишить их доступа к крови теперь практически невозможно, то ограничить доступ к земле, без которой они не могут отдыхать, вполне реально. Речь идёт о земле из ограниченного списка местностей в Восточной Европе: Румыния, Польша, Венгрия и прочие. Следовательно, им её нужно импортировать и это их слабость». # CLASS: tv # CLASS: voice
	- "…We need to deprive vampires of their means for surviving. And as we cannot close them off the fresh blood now, we can limit their access to soil that they need to rest. I am talking about a special kind of soil from the finite list of lands in Eastern Europe: Romania, Poland, Hungary, etc. They have to import it, therefore it is their weakness." # CLASS: tv # CLASS: voice
}
* [{lang ? rus:Слушать дальше|Listen further}]
-	{lang ? rus:
	- Тут вновь вступается высокий полицейский чин: # CLASS: tv
		«Текущая спецоперация как раз направлена на перекрытие одного из каналов поставки. Кроме того, это первая операция, проводимая совместно с силами специального назначения Церкви. Отец Кобб?» # CLASS: tv # CLASS: voice
	- Police high-rank comes in again:
		"This special operation is aimed to close one of these delivery channels. Moreover, it is the first operation carried out in collaboration with the Church's special forces. Father Cobb?" # CLASS: tv # CLASS: voice
}
* [{lang ? rus:Так, что-то новенькое|Well, that's new}]
-	{lang ? rus:
	- И опять священник: # CLASS: tv
		«Понимая серьёзность ситуации, кардинальской коллегией было принято решение о формировании отрядов по борьбе с вампирами, специально подготовленных для таких задач и способных в сжатые сроки переместиться в любую точку мира. Такой отряд был выслан и в наш город». # CLASS: tv # CLASS: voice
		В это время картинка показывает с десяток дюжих молодцев в чёрной экипировке и с белыми воротниками. # CLASS: tv
	- And the priest again:
		"The Catholic Church understands the severity of the situation and the College of Cardinals made a decision to form special units to deal with the threat. They are trained specifically on the task and are able to travel in any spot on the globe in no time. Such unit was sent to our city too." # CLASS: tv # CLASS: voice
		Meanwhile, the screen shows a dozen of hefty fellows in black outfits and with white collars. # CLASS: tv
}
-	(taskforce)
* [{lang ? rus:Приглядеться к их экипировке|Take a closer look at their outfits}]
	{lang ? rus:
		- Стандартное боевое снаряжение спецслужб: бронежилеты, шлемы, прыжковые костюмы. Исключение только одно — у каждого на шее белая колоратка. Боевые святые отцы, надо же.
		- A standard battle garment of spec ops: bulletproof vests, helmets, jumpsuits. With the only exception - each one sports the white collar. Battle holy fathers, wow.
	}
* [{lang ? rus:Приглядеться к их оружию|Take a closer look at their guns}]
	{lang ? rus:
		- Обычные с виду штурмовые винтовки, однако, подствольные фонари наверняка с ультрафиолетовыми лампами. Да и патроны, скорее всего, с нарезанными крестами, или вымоченные в святой воде, или ещё какая пакость.
		- Seem like usual assault rifles, but flashlights are definitely with UV-lamps. And bullets may be scratched with crosses or soaked in holy water or some other dirty tricks.
	}
-	{-> taskforce |}
	{lang ? rus:
		- Полицейский чин: # CLASS: tv
		«Прошу прощения, нам необходимо вернуться к координации операцией». # CLASS: tv # CLASS: voice
		Картинка переключается с него и Кобба на отряд святош, который времени не терял и уже гуськом приближается ко входу в дом. # CLASS: tv
		<span class='voice'>— Хефе… —</span> подаёт голос Десмод.
		- Police high-rank:
		"Please, excuse us. We should return to our duties." # CLASS: tv # CLASS: voice
		The camera view moves from him and Cobb to the unit of saints. They didn't waste their time and are closing to the house's entry now. # CLASS: tv
	}
* [{lang ? rus:Пить кофе|Drink coffee}]
-	{lang ? rus:
	- Я отпиваю очередной глоток, ожидая представления.
		Святоши на секунду замирают по обе стороны от входной двери дома, потом выламывают её и очень быстро исчезают внутри. # CLASS: tv
		Голос Десмонда напряжён:
		— Хефе, группа поддержки доберётся до места за десять минут. Только отдайте приказ. # CLASS: voice
		** — Десять минут — это слишком долго.[] <span class='coffee'>К тому же меня там нет.</span>
		-> strike
	- I make another sip waiting for the show.
		Zealots freeze for a moment at both sides of the door, then break it in and stream inside swiftly. # CLASS: tv
		Desmod's voice is tense:
		— Jefe, the support group is within ten minutes radius. Just give an order. # CLASS: voice
		** "Ten minutes are too long.["] <span class='coffee'>And by the way. I am not in that house."</span>
		-> strike
}
= strike
	{lang ? rus:
		- За тёмными окнами дома что-то вспыхивает и через мгновение сквозь них вырываются клубы огня. Ещё через мгновение камера дёргается и изображение пропадает. # CLASS: tv
		Откуда-то издалека я слышу хлопок и, повернувшись к окну, вижу, как где-то над ночным городом поднимается огненный столб взрыва.
		* — Десмод[.], на связи?
		-> last_order
		- Dark windows of the house flash and after a moment burst out with the fire. In another moment camera shakes and the TV screen darkens. # CLASS: tv
		I hear a muffled blast from somewhere far away, turn to the window, and see a column of explosion rasing above the night city.
		* "Desmod[."], do you copy?"
		->last_order
	}
= last_order
-	{lang ? rus:
	- — Конечно, хефе! # CLASS: voice
		— Усиль охрану грузовиков. Добавь больше бойцов на фабрику. И обзвоните всех клиентов, предупредите, что полоумные старики в Ватикане, наконец, зашевелились. Нужен общий сбор.
		— Принято, хефе. # CLASS: voice
		— Скоро буду. Отбой.
		Я вынимаю гарнитуру и бросаю к телефону.
	- "Of course, Jefe!" # CLASS: voice
		"Strengthen up the trucks' escorts. Add more gunners at the factory. And call to all of our clients, tell them that Vatican's old lunatics made their move. Time for a general meeting."
		"Will do, Jefe." # CLASS: voice
		"I'll be on the spot soon. Out."
		I take out the hands-free earplug and throw it to the phone.
}
* [{lang ? rus:Допить кофе|Finish the coffee}]
- (end)
	{lang ? rus:
		- Я делаю пару последних глотков, оставляя чёрную гущу осадка, и убираю чашку.
		Закидываю в рот пару пластинок мятной жвачки — нужно беречь клыки — надеваю плащ и выхожу из дома в ночь.
		Улица пустынна, лишь горят пара одиноких фонарей в конце квартала.
		Я подхожу к проволочному ограждению, за которым начинается обрыв, а ниже и до самого океана — раскинулся огромный город.
		- I make a couple of final sips leaving the black grounds and take away the cup.
		Then chew some gum plates — need to take care of the fangs — wear on the cloak and exit the house.
		The street is empty, only a couple of streetlights buzz at the end of the block.
		I approach the wire fence. Behind it, from the steps of a rocky cliff and to the very ocean — a huge city sprawls.
	}
*  {lang ? rus:Мой город|My city}[]. # CLASS: coffee
	{lang ? rus:
		- И я не позволю каким-то клоунам в сутанах всё испортить, когда веселье только началось.
		Я расправляю чёрные крылья и взмываю в звёздное небо.
		- And I won't allow some cassock-sporting clowns to ruin everything. The funny part is just beginning.
		I spread black wings and soar in the starry sky. 
	}
	<p class="logo"><svg style="width: 75px;height: 90px;"><path d="M60,30 L60,30 L60,30 M60,15 L60,15 L60,15 M45,15 L45,15 L45,30 M30,15 L30,15 L30,15 M30,30 L30,30 L30,30 M15,15 L15,15 L15,30 M15,45 L15,45 L30,45 M15,60 L15,60 L30,60 M45,45 L45,45 L45,60 M60,60 L60,60 L60,45 " style="stroke-width: 12; stroke-linecap: square; stroke-linejoin: bevel; stroke: rgb(34, 35, 35); fill: none;"/></svg></p>
-> END

// functions
== function kitchen_cupboards(case)
	~ temp check = (beans, ibrik, grinder)
	{
		- LIST_COUNT(coffeeIngredients ^ check) == 0:
			{
				- lang ? rus:
					{case == 1: один из шкафов}
					{case == 2: одном из шкафов}
					{case == 3: одного из шкафов}
				- lang ? eng:
					one of the cupboards
			}
		- LIST_COUNT(coffeeIngredients ^ check) == 1:
			{
				- lang ? rus:
					{case == 1: другой шкаф}
					{case == 2: другом шкафу}
					{case == 3: другого шкафа}
				- lang ? eng:
					another cupboard
			}
		- LIST_COUNT(coffeeIngredients ^ check) == 2:
			{
					- lang ? rus:
						{case == 1: очередной шкаф}
						{case == 2: очередном шкафу}
						{case == 3: очередного шкафа}
					- lang ? eng:
					the last cupboard
			}
	}