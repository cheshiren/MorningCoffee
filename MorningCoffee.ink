//
//Десмод
//Стрикс|Неясыть


// -> NEWS54.end
// -> NEWS54
-> top

LIST lang = rus, (eng)

LIST coffeeState = beans_are_ground, ingredients_added, ingredients_mixed, heated_1st_time, boiled_1st_time, heated_2nd_time, boiled_2nd_time, heated_3rd_time,boiled_3rd_time, in_cup, ground_settled, ready
LIST coffeeIngredients = beans, ibrik, water, coffee, sugar, grinder

LIST phoneTalk = greetings, cargo_start, hungary_start, hungary_end, soon_start, soon_end, cargo_end, stuff_start, loaders_start, loaders_end, enforcers_start, enforcers_end, stuff_end, clients_start, clients_end
VAR need_answer = false

LIST tvChannel = music, news

LIST musicPlays = riffs, girl_screams, za_starts, za_cont, za_ends
// смена музыкального фона - каждые 5 ходов:
VAR song = 5

VAR end_1st_part = false

* [Русский]
	~ lang += rus
* [English]
	~ lang += eng
-


{lang ? rus:
	- Я стою на краю обрыва и смотрю на восток, на горизонт, откуда вот-вот покажется солнце. Снимаю мотоциклетный шлем и оскаливаюсь в ухмылке. Ну давай же.
	- I stand on the edge of a cliff and look to the east, awaiting for the sun to emerge. I take off the bike helmet and grin. Come on, show yourself.
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
			I lie for a couple of minutes looking at the dark ceiling, then glance at the wristwatch: half past six. Time to rise up.
		}
		*** [>>]
			{lang ? rus:
				- Накинув халат, протопав в ванную, проведя все необходимые процедуры, я спускаюсь в холл и оттуда в кухню. Утро должно начинаться с чашки хорошего, крепкого кофе.
				А кофе я пью по-турецки.
				- I wear the bathrobe, step into bathroom, do all the rituals, then go down in the hall and enter the kitchen. The day should start with the cup of good strong coffee.
				And I prefer Turkish one.
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
			- I open {kitchen_cupboards(1)} in my hi-tech kitchen and reveal the ibrik. Real, made of copper. Doesn't match the overall style at all. Put it on the cold stove.
		}
		~coffeeIngredients += ibrik
	* {coffeeIngredients !? beans} [{lang ? rus:Найти зёрна|Find the beans}]
		{lang ? rus:
			- В {kitchen_cupboards(2)} я нахожу джутовый мешочек с трафаретной надписью «Cafés do Brasil» и ставлю {coffeeIngredients !? grinder:на стойку|рядом с мельницей}.
			- Inside {kitchen_cupboards(1)} I find a little jute bag with the stencil "Cafés do Brasil" and put it {coffeeIngredients !? grinder:on the counter|next to the grinder}.
		}
		~coffeeIngredients += beans
	* {coffeeIngredients !? grinder} [{lang ? rus:Найти мельницу|Find the grinder}]
		{lang ? rus:
			- Из {kitchen_cupboards(3)} я осторожно вынимаю ручную мельницу и выставляю {coffeeIngredients !? beans:на стойку|рядом с зёрнами}. Немецкий антиквариат времён кайзера. На белой эмали, покрытой паутиной трещин, — чёрные готические буквы: «Kaffee».
			- From {kitchen_cupboards(1)} I take out hand grinder and stand it {coffeeIngredients !? beans:on the counter|next to the beans}. German antiques of Kaiser times. White enamel covered with the web of cracks bears the black gothic letters: "Kaffee".
		}
		~coffeeIngredients += grinder
	* {coffeeState < beans_are_ground && coffeeIngredients ? beans && coffeeIngredients ? grinder} [Смолоть зёрна]
		Развязываю мешочек, пахну́вший жареным кофе, набираю полную пригоршню и ссыпаю в чашу на мельнице. Не торопясь, кручу ручку, слушая хруст зёрен.// Когда чаша пустеет, выдвигаю ёмкость снизу, пересыпаю её содержимое назад в чашу и снова кручу ручку. Повторяю несколько раз, пока не получаю очень тонкий помол.
		~coffeeState -= coffeeState
		~coffeeState += beans_are_ground
	* {coffeeIngredients !? coffee && coffeeIngredients ? ibrik && coffeeState == beans_are_ground} [Насыпать смолотый кофе]
		Набираю полную столовую ложку молотого кофе и задумываюсь: не мало?
		** [Хватит и ложки]
			Решаю, что с таким тонким помолом кофе получится достаточно крепким,
		** (dark_coffee)[Набрать ложку с горкой]
			Решаю, что как раз сейчас мне не помешает дополнительный заряд бодрости, добираю кофе с горкой,
		--	<> и ссыпаю его в турку.
			~coffeeIngredients += coffee
	* {coffeeIngredients !? sugar && coffeeIngredients ? ibrik} [Насыпать сахар]
		Придвинув хромированную сахарницу, задумываюсь, какой кофе мне сейчас хочется?
		** (az_sekerli) [Az Şekerli (меньше чайной ложки сахара)]
		** (orta_sekerli) [Orta Şekerli (с парой чайных ложек)]
		** (sekerli) [Şekerli (с тремя чайными ложками)]
		--	Насыпаю желаемое количество белого песка в турку.
			~coffeeIngredients += sugar
	* {coffeeIngredients !? water && coffeeIngredients ? ibrik} [Налить в турку воды]
		Наполняю турку до половины водой из фильтра.
		~coffeeIngredients += water
	* {coffeeState == ingredients_added} [Перемешать содержимое турки]
		Тщательно перемешиваю воду, кофе и сахар, пока не получаю однородную взвесь.
		~coffeeState -= coffeeState
		~coffeeState += ingredients_mixed
	* (heat1) {coffeeState == ingredients_mixed} [Поставить турку на медленный огонь]
		Щёлкнув пару раз ручкой плиты, ставлю турку прямо на центр конфорки.
		~coffeeState -= coffeeState
		~coffeeState += heated_1st_time
	+ {coffeeState == heated_1st_time || coffeeState == heated_2nd_time || coffeeState == heated_3rd_time} [Ждать, пока готовится кофе]
	* (heat2) {coffeeState == boiled_1st_time} [Снять турку с огня]
		По кухне уже разносится аромат {dark_coffee: крепкого }кофе. Убираю турку с плиты и ложкой снимаю всю пену в чашку. Ставлю турку назад на конфорку.
		~coffeeState -= coffeeState
		~coffeeState += heated_2nd_time
	* (heat3) {coffeeState == boiled_2nd_time} [Ещё раз снять турку с огня]
		Во второй раз снимаю турку с плиты и тонкой струйкой выливаю половину кофе в чашку.
		Возвращаю турку на конфорку.
		~coffeeState -= coffeeState
		~coffeeState += heated_3rd_time
	* {coffeeState == boiled_3rd_time} [Окончательно снять турку с огня]
		~coffeeState -= coffeeState
		~coffeeState += in_cup
		Выключаю плиту, в последний раз снимаю турку и аккуратно выливаю оставшуюся половину кофе в чашку, стараясь не слить кофейную гущу из турки.
	* {coffeeState == in_cup} [Подождать, пока в чашке опустится осадок]
		~ coffeeState++
		Пока кофе в чашке «доходит», я убираю назад всё, что доставал из шкафов, вытряхиваю и ополаскиваю турку. Остался последний штрих.
	* {coffeeState == ground_settled} [Добавить в кофе немного «приправы»]
		~ coffeeState++
		Открываю холодильник, достаю пакет багряной жидкости и несколько раз встряхиваю.
			** [Добавить одну каплю]
				Задумываюсь, когда в последний раз пил кофе со свежей «приправой», без антикоагулянта. Но тут же отгоняю мрачные мысли и выдавливаю одну каплю в чашку.
			** [Добавить несколько капель]
				Возможно, появится привкус антикоагулянта, но хочется себя побаловать. Выдавливаю несколько капель в чашку.
			--	<> Убираю пакет.
				Кофе готов.
	+ {coffeeState == ready && !end_1st_part} [Пить кофе]
		{ stopping:
			- Я двумя пальцами подношу чашку к губам и, вдыхая аромат, делаю первый, самый важный глоток.
			{
				- az_sekerli: Чистая
				- orta_sekerli: Подслащённая
				- sekerli: Сладкая
			}
			<>{dark_coffee:, терпкая} горечь мгновенно отбирает на себя всё внимание чувств, ослепительной вспышкой перегружает сенсорику. Медный привкус «приправы» оттеняет эту горечь и добавляет нотку особого томления, мало кому знакомого. # CLASS: coffee
			Да, отличный вышел кофе.
			- Я встаю у окна и пью кофе маленькими глотками, наслаждаясь и глядя на огни ночного города.
			- Я наслаждаюсь своим кофе, глядя в окно, когда Десмод вдруг замолкает.
				~ end_1st_part = true
				** — Десмод?
					-> NEWS54
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
			Мимоходом клацаю лежащий тут же пульт от телевизионной панели за спиной. <span class="tv">Всё свободное пространство заполняется звуками мрачных гитарных риффов.</span>
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
					{TURNS_SINCE(-> turn) == 0: Но вот| От телевизионной панели слышно, как} к гитарам присоединяется женский вокал и, срываясь на визг, начинает кричать о «сёстрах на кострах». # CLASS: tv
				- musicPlays ? za_starts:
					Песня, гремящая по телевизору, стихает на одном протяжном риффе и через несколько секунд тишины начинается другая. # CLASS: tv
				- musicPlays ? za_cont:
					От телевизионной панели слышно, как то, что поначалу показалось госпелом, превращается во что-то по-настоящему тёмное и мрачное. # CLASS: tv
				- musicPlays ? za_ends:
					«Псевдо-госпел» завершается сходящим на нет скримом вокалиста. Неплохо. # CLASS: tv
			}
		- Music % song == 1:
			{
				- musicPlays ? za_starts:
					Я вдруг понимаю, что мелодия и вокал новой песни слишком похожи на госпел. Уже тянусь к пульту, когда первые же строчки развеивают мои опасения. # CLASS: tv
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
			Чёрный прямоугольник телефона издаёт мелодичную трель и просыпается с именем на весь экран: «Десмод».
		- ring == 2:
			Телефон продолжает звонить.
		- ring == 3:
			Телефон всё звонит.
		- ring == 4:
			От телефона раздаётся сигнал включения автоответчика и доносится голос помощника:
			— Хефе, это Десмод. Как договаривались, звоню с отчётом. # CLASS: voice
			Я подхватываю наушник гарнитуры, вставляю в ухо и жму кнопку приёма:
			<- talk
	}
= text
	{	
		
		- phoneTalk ? soon_start && phoneTalk !? soon_end:
		{ once:
			- 
			- Из наушника доносится голос Десмода\:
				— …Сможем отвезти заказ на Холмы, семье Алистера… # CLASS: voice
			- — …Потом Северо-Запад, Эмбаркадеро, Промзона… # CLASS: voice
			- — …Подключим ещё ребят и да, думаю, управимся раньше. # CLASS: voice
			~ phoneTalk += soon_end
			{ phoneTalk ? hungary_end:
				<> У меня по грузу вся информация, хефе. Что-нибудь ещё?
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
			- Десмод продолжает докладывать в наушник\:
				— …Перевезли всё несколькими рейсами на фабрику, разгрузили в дальних складах… # CLASS: voice
			-	— …Сейчас парни делят груз на партии, в течение суток сможем начать развозить по клиентам. # CLASS: voice
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
			- — …В машинах сопровождения по наблюдателю и два оператора… # CLASS: voice
			- — …В случае чего, на связи всегда отдельная группа поддержки… # CLASS: voice
			- — …Но никаких эксцессов не ожидаем. В последнее время всё тихо. # CLASS: voice
			~ phoneTalk += enforcers_end
			{ phoneTalk ? loaders_end:
				<> У меня по штату всё. Что-то ещё, хефе?
				~ phoneTalk += stuff_end
			}
			<- talk
		}
		- phoneTalk ? stuff_start && phoneTalk !? stuff_end:
		{ once:
			- 
			- Десмод продолжает докладывать в наушник\:
				— …Шестеро водителей, сейчас все на линии. У каждого по рейсу, потом возвращаются на базу. # CLASS: voice
			// ~ phoneTalk += stuff_end
			<- talk
		}
		- phoneTalk ? clients_start && phoneTalk !? clients_end && !end_1st_part:
		{ once:
			- 
			- — …Новичкам из пригорода отвезли семь объёмов, они явно расширяются, нужно взять на заметку… # CLASS: voice
			- — …Марку Питбулю доставили новый объём бесплатно, прошлый заказ и правда оказался некачественным — поставщик разбавил местной глиной, с ним уже разобрались… # CLASS: voice
			- — …По отработанным заказам всё. На сегодня у нас новая партия. Как я говорил, сначала доставляем старику Алистеру и его выводку на Холмы — шесть объёмов… # CLASS: voice
			- — …Клиенты из Северо-Запада покупают редко и немного, но платят всегда хорошо и в срок. На сегодня закзали два объёма… # CLASS: voice
			- — …Дальше тот хлыщ из Эмбаркадеро. Своего ковена не заводит, но объём обновляет регулярно, поэтому предпоследний рейс к нему… # CLASS: voice
			- — … # CLASS: voice
			// ~ phoneTalk += stuff_end
			<- talk
		}
	}
-> DONE

= opts
	{LIST_COUNT(coffeeIngredients) <= 4: -> DONE}
	* {ring < 3 && phoneTalk !? greetings} [Ответить на звонок]
	* {ring >= 3 && phoneTalk !? greetings} [Всё таки ответить на звонок]
	- (took)
		Я подхватываю наушник гарнитуры, вставляю в ухо и жму кнопку приёма:
		— Десмод?
		— Хола, хефе. Как договаривались, звоню с отчётом. # CLASS: voice
		<- talk
= talk
	~ need_answer = true
	~ phoneTalk += greetings
	* {phoneTalk !? cargo_start and !(phoneTalk ? stuff_start && phoneTalk !? stuff_end)} — Рассказывай про груз.
		— Груз прибыл в порт шесть часов назад. Два контейнера, по тридцать кубов каждый… # CLASS: voice
		~ phoneTalk += cargo_start
	* {phoneTalk ? cargo_start && phoneTalk !? cargo_end && phoneTalk !? hungary_start} — Землю-то проверили?
		— Да, хефе. Наилучший венгерский чернозём. Стрикс его чуть ли не есть начал, когда вскрыли мешки. # CLASS: voice
		Я оставляю его комментарий без внимания.
		{ phoneTalk ? soon_end:
			— У меня по грузу вся информация. Что-нибудь ещё, хефе? # CLASS: voice
		}
		~ phoneTalk += hungary_start
	* {phoneTalk ? cargo_start && phoneTalk !? cargo_end && phoneTalk !? soon_start} — Сутки — слишком много. Когда будут готовы первые партии?
		— Так. Ну первую «Вольво» парни загрузят часа через три, думаю… # CLASS: voice
		~ phoneTalk += soon_start
	* {phoneTalk !? stuff_start and !(phoneTalk ? cargo_start && phoneTalk !? cargo_end)} — Рассказывай про штат.
		— Сегодня по спискам вышли: двенадцать грузчиков, из них восемь на фабрике, четверо на линии… # CLASS: voice
		~ phoneTalk += stuff_start
	* {phoneTalk ? stuff_start && phoneTalk !? stuff_end && phoneTalk !? loaders_start} — {phoneTalk ? enforcers_end: А что, есть|Есть} машины в рейсах без грузчиков?
		— Да, там небольшие заказы, водители сами справятся. # CLASS: voice
		{ phoneTalk ? enforcers_end:
			<> У меня по штату всё. Что-то ещё, хефе? # CLASS: voice
		}
		~ phoneTalk += loaders_start
	* {phoneTalk ? stuff_start && phoneTalk !? stuff_end && phoneTalk !? enforcers_start} — А что с охраной?
		— За каждым грузовиком закреплено по машине сопровождения… # CLASS: voice
		~ phoneTalk += enforcers_start
	* {phoneTalk ? cargo_end && phoneTalk ? stuff_end && phoneTalk !? clients_start} — Давай пройдёмся по списку клиентов. Кто отработан, кто в очереди и так далее.
		— Так. Из тех заказов, что запланированны на этой неделе уже доставлены: группе Маддса, что в южных районах — четыре объёма… # CLASS: voice
		~ phoneTalk += clients_start
	-
	~ need_answer = false
	-> top

== NEWS54
— Хефе, у вас работает телевизор? Скорее переключитесь на новостной канал! # CLASS: voice
* [Переключить канал]
-	Я подхватываю пульт телевизионной панели и на пути к ней жму цифры новостного канала.
	На экране — ночь, улица в пригороде, двухэтажный белый дом. Вокруг дома — полицейское оцепление. Маячки нескольких машин заливают улицу красным и синим светом. Надпись в углу: «Прямой эфир». # CLASS: tv
	«…продолжается полицейская операция по задержанию опасного преступника. Личность задерживаемого пока не раскрывается, только то, что он как-то связан с известными событиями последних нескольких месяцев: нападением на Тринадцатое полицейское отделение, взрывами на объектах транспортного управления, массовым исчезновением людей…» # CLASS: tv # CLASS: voice
* [Смотреть сюжет]
-	Картинка на экране меняется: репортёр берёт интервью у высокого полицейкого чина. На фоне всё так же мечется красно-синий свет. # CLASS: tv
	«По нашим данным субъект, живущий в этом доме, является главой картеля, занимающегося крупными контрабандными перевозками. Таким образом, он является ключевым звеном в логистике у криминальных организаций, наводнивших наш город в последний год». # CLASS: tv # CLASS: voice
	Голос Десмода в наушнике:
	— Хефе, это же на вашей улице! Разве это не ваш дом!? # CLASS: voice
* [Игнорировать Десмода]
* — Тише, Десмод. Дай посмотреть.
- «Простите, но контрабандой чего занимается этот картель?» # CLASS: tv # CLASS: voice
	«Земли». # CLASS: tv # CLASS: voice
	«Земли?» # CLASS: tv # CLASS: voice
	«Да. Земли из Восточной Европы. И перед тем, как вы зададите свой следующий вопрос, я попрошу выступить нашего консультанта от Римской католической церкви. Отец Кобб, будьте добры». # CLASS: tv # CLASS: voice
* [Смотреть дальше]
-	<span class='tv'>На экране появляется хмурый священник в чёрной сутане с неизменной книжкой в руках.</span> Я салютую ему чашкой кофе.
	«Я знаю, что многие из вас не верят. Уже много месяцев правительства твердят об угрозе, но всё это больше похоже на истории из дешёвых романов и посредственного кино. Однако, уверяю вас — угроза вполне реальна. Церковь веками боролась с этой заразой, сдерживала её…» # CLASS: tv # CLASS: voice
* [Фыркнуть]
-	В этом месте я презрительно фыркаю.
	«…Но современный мир оказался слишком восприимчив к ней. И наш город, как и многие другие в мире, сейчас захлёстывает эпидемия — да-да, именно эпидемия — вампиризма. Чтобы сдержать её, уже недостаточно просто точечного ликвидирования верховного вампира, или упыря, или стригоя. Нужен системный подход…» # CLASS: tv # CLASS: voice
* [Слушать священника]
-	«…Нужно лишить вампиров одного из средств существования. И если лишить их доступа к крови теперь практически невозможно, то ограничить доступ к земле, без которой они не могут отдыхать, вполне реально. Речь идёт о земле из ограниченного списка местностей в Восточной Европе: Румыния, Польша, Венгрия и прочие. Следовательно, им её нужно импортировать и это их слабость». # CLASS: tv # CLASS: voice
* [Слушать дальше]
-	Тут вновь вступается высокий полицейский чин: # CLASS: tv
	«Текущая спецоперация как раз направлена на перекрытие одного из каналов поставки. Кроме того, это первая операция, проводимая совместно с силами специального назначения Церкви. Отец Кобб?» # CLASS: tv # CLASS: voice
* [Так, что-то новенькое]
-	И опять священник: # CLASS: tv
	«Понимая серьёзность ситуации, кардинальской коллегией было принято решение о формировании отрядов по борьбе с вампирами, специально подготовленных для таких задач и способных в сжатые сроки переместиться в любую точку мира. Такой отряд был выслан и в наш город». # CLASS: tv # CLASS: voice
	В это время картинка показывает с десяток дюжих молодцев в чёрной экипировке и с белыми воротниками. # CLASS: tv
-	(taskforce)
* [Приглядеться к их экипировке]
	Стандартное боевое снаряжение спецслужб: бронежилеты, шлемы, прыжковые костюмы. Исключение только одно — у каждого на шее белая колоратка. Боевые святые отцы, надо же.
* [Приглядеться к их оружию]
	Обычные с виду штурмовые винтовки, однако, подствольные фонари наверняка с ультрафиолетовыми лампами. Да и патроны, скорее всего, с нарезанными крестами, или вымоченные в святой воде, или ещё какая пакость.
-	{-> taskforce |}
	Полицейский чин: # CLASS: tv
	«Прошу прощения, нам необходимо вернуться к координации операцией». # CLASS: tv # CLASS: voice
	Картинка переключается с него и Кобба на отряд святош, который времени не терял и уже гуськом приближается ко входу в дом. # CLASS: tv
	<span class='voice'>— Хефе… —</span> подаёт голос Десмод.
* [Пить кофе]
-	Я отпиваю очередной глоток, ожидая представления.
	Святоши на секунду замирают по обе стороны от входной двери дома, потом выламывают её и очень быстро исчезают внутри. # CLASS: tv
	Голос Десмонда напряжён:
	— Хефе, группа поддержки доберётся до места за десять минут. Только отдайте приказ. # CLASS: voice
* — Десять минут — это слишком долго.[] <span class='coffee'>К тому же меня там нет.</span>
-	За тёмными окнами дома что-то вспыхивает и через мгновение сквозь них вырываются клубы огня. Ещё через мгновение камера дёргается и изображение пропадает. # CLASS: tv
	Откуда-то издалека я слышу хлопок и, повернувшись к окну, вижу, как где-то над ночным городом поднимается огненный столб взрыва.
* — Десмод[.], на связи?
-	— Конечно, хефе! # CLASS: voice
	— Усиль охрану грузовиков. Добавь больше бойцов на фабрику. И обзвоните всех клиентов, предупредите, что полоумные старики в Ватикане, наконец, зашевелились. Нужен общий сбор.
	— Принято, хефе. # CLASS: voice
	— Скоро буду. Отбой.
	Я вынимаю гарнитуру и бросаю к телефону.
* [Допить кофе]
- (end)	Я делаю пару последних глотков, оставляя чёрную гущу осадка, и убираю чашку.
	Закидываю в рот пару пластинок мятной жвачки — нужно беречь клыки — надеваю плащ и выхожу из дома в ночь.
	Улица пустынна, лишь горят пара одиноких фонарей в конце квартала.
	Я подхожу к проволочному ограждению, за которым начинается обрыв, а ниже и до самого океана — раскинулся огромный город.
* Мой город[]. # CLASS: coffee
	И я не позволю каким-то клоунам в сутанах всё испортить, когда веселье только началось.
	Я расправляю чёрные крылья и взмываю в звёздное небо.
	<p class="logo"><svg style="width: 75px;height: 90px;"><path d="M60,30 L60,30 L60,30 M60,15 L60,15 L60,15 M45,15 L45,15 L45,30 M30,15 L30,15 L30,15 M30,30 L30,30 L30,30 M15,15 L15,15 L15,30 M15,45 L15,45 L30,45 M15,60 L15,60 L30,60 M45,45 L45,45 L45,60 M60,60 L60,60 L60,45 " style="stroke-width: 12; stroke-linecap: square; stroke-linejoin: bevel; stroke: rgb(58, 58, 58); fill: none;"/></svg></p>
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