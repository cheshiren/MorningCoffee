//
//Десмод
//Стрикс|Неясыть

// -> NEWS54
// -> top

LIST coffeeState = beans_are_ground, ingredients_added, ingredients_mixed, heated_1st_time, boiled_1st_time, heated_2nd_time, boiled_2nd_time, heated_3rd_time,boiled_3rd_time, in_cup, ground_settled, ready
LIST coffeeIngredients = beans, ibrik, water, coffee, sugar, grinder

LIST phoneTalk = greetings, cargo_start, hungary_start, hungary_end, soon_start, soon_end, cargo_end, stuff_start, loaders_start, loaders_end, enforcers_start, enforcers_end, stuff_end, clients_start, clients_end
VAR need_answer = false

LIST tvChannel = music, news

LIST musicPlays = riffs, girl_screams, za_starts, za_cont, za_ends
// смена музыкального фона - каждые 5 ходов:
VAR song = 5

VAR end_1st_part = false

Я стою на краю обрыва и смотрю на восток, на горизонт, откуда вот-вот покажется солнце. Снимаю мотоциклетный шлем и оскаливаюсь в ухмылке. Ну давай же.
* [>>]
	Первые лучи брызжут раскалённым железом. Ослеплённый, я чувствую их пламенные объятия на своей коже. Я хохочу.
	** [>>] И просыпаюсь.
			Пару минут лежу, глядя на тёмный потолок, потом подношу к глазам руку с часами: половина седьмого. Пора вставать.
			*** [>>]
				Накинув халат, протопав в ванную, проведя все необходимые процедуры, я спускаюсь в холл и оттуда в кухню. Утро должно начинаться с чашки хорошего, крепкого кофе.
				А кофе я пью по-турецки.

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
	* {coffeeIngredients !? ibrik} [Найти турку]
		Открыв {kitchen_cupboards(1)} своей хайтековской кухни, достаю оттуда турку. Настоящую, медную. Совсем не подходящую по стилю окружающей мебели. Ставлю её на холодную плиту.
		~coffeeIngredients += ibrik
	* {coffeeIngredients !? beans} [Найти зёрна]
		В {kitchen_cupboards(2)} я нахожу джутовый мешочек с трафаретной надписью «Cafés do Brasil» и ставлю {coffeeIngredients !? grinder:на стойку|рядом с мельницей}.
		~coffeeIngredients += beans
	* {coffeeIngredients !? grinder} [Найти мельницу]
		Из {kitchen_cupboards(3)} я осторожно вынимаю ручную мельницу и выставляю {coffeeIngredients !? beans:на стойку|рядом с зёрнами}. Немецкий антиквариат времён кайзера. На белой эмали, покрытой паутиной трещин, — чёрные готические буквы: «Kaffee».
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
				Выдавливаю одну каплю в чашку.
			** [Добавить несколько капель]
				Выдавливаю несколько капель в чашку.
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
			- Я встаю у окна и пью кофе маленькими глотками, наслаждаясь и глядя на темнеющую улицу.
			- Я наслаждаюсь своим кофе, глядя в окно, когда Десмод вдруг осекается на полуслове.
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
					Песня стихает на одном протяжном риффе и через несколько секунд тишины начинается другая. # CLASS: tv
				- musicPlays ? za_cont:
					Я слышу, как то, что поначалу показалось мне госпелом, превращается во что-то по-настоящему тёмное и мрачное. Какой у вокалиста интересный тембр. # CLASS: tv
				- musicPlays ? za_ends:
					Песня завершается сходящим на нет скримом вокалиста. Да, неплохо. Нужно будет потом переслушать. # CLASS: tv
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
			От телефона раздаётся щелчок включения автоответчика и доносится голос помощника:
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
			- — …В машинах сопровождения по наблюдателю и по два оператора… # CLASS: voice
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
			- — …Клиенты2. # CLASS: voice
			- — …Клиенты3. # CLASS: voice
			- — …Клиенты4. # CLASS: voice
			- — …Клиенты5. # CLASS: voice
			- — …Клиенты6. # CLASS: voice
			- — …Клиенты7. # CLASS: voice
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
		— Да, хефе. Наилучший венгерский грунт. Стрикс его чуть ли не есть начал, когда вскрыли мешки. # CLASS: voice
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
		— Так. Из тех заказов, что запланированны на этой неделе уже доставлены: … # CLASS: voice
		~ phoneTalk += clients_start
	-
	~ need_answer = false
	-> top

== NEWS54
— Хефе, у вас работает телевизор? Скорее переключитесь на новостной канал! # CLASS: voice
* [Переключить канал]
	Я подхватываю пульт от телевизионной панели и на пути к ней жму «5-4», переключаясь на новости.
	ТВ-картинка: ночь, улица в пригороде, вокруг дома — оцепление из полицейских машин. # CLASS: tv
	«…полицейская операция по задержанию опасного преступника…» # CLASS: tv # CLASS: voice
	** [Смотреть новостной сюжет]
		ТВ-картинка: репортёр берёт интервью у высокого полицейкого чина. # CLASS: tv
		«…в рамках борьбы с вампирской эпидемией — глава одного из самых успешных картелей…» # CLASS: tv # CLASS: voice
		Голос Десмода в наушнике:
		— Хефе, это же на вашей улице! Разве это не ваш дом!? # CLASS: voice
		*** [Игнорировать Десмода]
		*** — Тише, Десмод. Смотри внимательно.
		--- «…отец Брук…» # CLASS: tv # CLASS: voice
			ТВ-картинка: появляется священник в сутане, я салютую ему чашкой с кофе. # CLASS: tv
			«…эпидемия захлестнула город — можем излечить её, если лишим вампиров возможности спать, лишим доступа к грунту из определённых местностей Восточной Европы…» # CLASS: tv # CLASS: voice
			**** [Слушать священника]
				«…для противодействия угрозе Римская католическая церковь сформировала боевые отряды…» # CLASS: tv # CLASS: voice
				ТВ-картинка: с десяток дюжих молодцев в чёрной экипировке и с белыми воротниками. # CLASS: tv
			---- (taskforce)
				***** [Приглядеться к их экипировке]
					Стандартное боевое снаряжение спецслужб: бронежилеты, шлемы, прыжковые костюмы. Исключение только одно — у каждого на шее белая колоратка. Боевые святые отцы, надо же.
				***** [Приглядеться к их оружию]
					Обычные с виду штурмовые винтовки, однако, подствольные фонари наверняка с ультрафиолетовыми лампами. Да и патроны, скорее всего, с нарезанными крестами, или вымоченные в святой воде, или ещё какая пакость.
				----- {-> taskforce |}
				ТВ-картинка: Тем временем отряд святош гуськом приближается ко входу в дом. На секунду они замирают по обе стороны от двери, потом выламывают её и очень быстро исчезают внутри. # CLASS: tv
				Голос Десмонда напряжён:
				— Хефе, группа поддержки доберётся до места за десять минут. Только отдайте приказ. # CLASS: voice
				***** — Десять минут — это слишком долго.[] К тому же меня там давно нет.
					ТВ-картинка: за тёмными окнами дома что-то вспыхивает и через мгновение сквозь них вырываются клубы огня. Ещё через мгновение камера дёргается и изображение пропадает. # CLASS: tv
					Откуда-то издалека я слышу хлопок и, повернувшись к окну, вижу, как где-то над ночным городом поднимается огненный столб дыма.
-> END

// functions
== function kitchen_cupboards(case)
	~ temp check = (beans, ibrik, grinder)
	{
		- LIST_COUNT(coffeeIngredients ^ check) == 0:
			{case == 1: один из шкафов}
			{case == 2: одном из шкафов}
			{case == 3: одного из шкафов}
		- LIST_COUNT(coffeeIngredients ^ check) == 1:
			{case == 1: другой шкаф}
			{case == 2: другом шкафу}
			{case == 3: другого шкафа}
		- LIST_COUNT(coffeeIngredients ^ check) == 2:
			{case == 1: очередной шкаф}
			{case == 2: очередном шкафу}
			{case == 3: очередного шкафа}
	}