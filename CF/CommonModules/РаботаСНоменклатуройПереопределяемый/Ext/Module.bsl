﻿
////////////////////////////////////////////////////////////////////////////////
// Подсистема "Работа с номенклатурой".
// ОбщийМодуль.РаботаСНоменклатуройПереопределяемый.
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#Область АвтоподборНоменклатуры

// Заполнение массива имен полей формы, по которым будет складываться поисковая строка
// для подбора 1С:Номенклатуры при заполнении номенклатуры информационной базы.
// Обрабатывается событие ИзменениеТекстаРедактирования.
//
// Параметры:
//  МассивПолей - Массив - (Строка) массив имен полей полей.
//
Процедура ЗаполнитьМассивПолейСобытияИзменениеТекстаРедактирования(МассивПолей) Экспорт
	
	МассивПолей.Добавить("Наименование");
	
КонецПроцедуры

// Заполнение массива имен полей формы, по которым будет складываться поисковая строка
// для подбора 1С:Номенклатуры при заполнении номенклатуры информационной базы.
// Обрабатывается событие ПриИзменении.
//
// Параметры:
//  МассивПолей - Массив - (Строка) массив имен полей полей.
//
Процедура ЗаполнитьМассивПолейСобытияПриИзменении(МассивПолей) Экспорт
	
КонецПроцедуры

#КонецОбласти

#Область СозданиеОбъектовИнформационнойБазы

// Создание вида номенклатуры в информационной базе.
//
// Параметры:
//  ДанныеЗаполнения - СтрокаТаблицыЗначений - данные, на основании которых идет заполнение объекта. 
//                                             Описание таблицы значений см. РаботаСНоменклатурой.ДанныеКатегорийСервиса
//  ВидНоменклатурыСсылка - Ссылка - ссылка на новый элемент.
//
Процедура СоздатьВидНоменклатуры(ДанныеЗаполнения, ВидНоменклатурыСсылка) Экспорт
		
	СтавкаНДС = Перечисления.СтавкиНДС.ПустаяСсылка();
	ПреобразоватьСтавкуНДССервиса(ДанныеЗаполнения.СтавкаНДС, СтавкаНДС);
	
	ТипНоменклатуры = Перечисления.ТипыНоменклатуры.ПустаяСсылка();
	ПреобразоватьТипНоменклатурыСервиса(ДанныеЗаполнения.Тип, ТипНоменклатуры);
	
	// Заполнение объекта
	
	ВидНоменклатурыОбъект = Справочники.ВидыНоменклатуры.СоздатьЭлемент();
	
	ВидНоменклатурыОбъект.Заполнить(Неопределено);
	ВидНоменклатурыОбъект.УстановитьНовыйКод();
	
	ВидНоменклатурыОбъект.Наименование    = ДанныеЗаполнения.Наименование;
	ВидНоменклатурыОбъект.СтавкаНДС       = СтавкаНДС;
	ВидНоменклатурыОбъект.ТипНоменклатуры = ТипНоменклатуры;
	
	ВидНоменклатурыОбъект.Записать();
	
	ВидНоменклатурыСсылка = ВидНоменклатурыОбъект.Ссылка;
	
КонецПроцедуры

// Создание номенклатуры в информационной базе.
//
// Параметры:
//  ДанныеЗаполнения - СтрокаТаблицыЗначений - данные, на основании которых идет заполнение объекта.
//                                             Описание таблицы значений см. РаботаСНоменклатурой.ДанныеНоменклатурыСервиса
//  НоменклатураСсылка - Ссылка - ссылка на новый элемент.
//
Процедура СоздатьНоменклатуру(ДанныеЗаполнения, НоменклатураСсылка) Экспорт
	
	// Подготовка данных
	
	СтавкаНДС = Перечисления.СтавкиНДС.ПустаяСсылка();
	ПреобразоватьСтавкуНДССервиса(ДанныеЗаполнения.СтавкаНДС, СтавкаНДС);
	
	СсылкаНаЕдиницуИзмерения = Справочники.БазовыеЕдиницыИзмерения.ПустаяСсылка();
	ЕдиницаИзмеренияПоДаннымСервиса(ДанныеЗаполнения.ЕдиницаИзмерения, СсылкаНаЕдиницуИзмерения);
	// Заполнение объекта
	
	НоменклатураОбъект = Справочники.Номенклатура.СоздатьЭлемент();
	НоменклатураОбъект.Заполнить(Неопределено);
	
	НоменклатураОбъект.УстановитьНовыйКод();
	
	НаименованиеПолное = ?(ЗначениеЗаполнено(ДанныеЗаполнения.НаименованиеДляПечати), 
		ДанныеЗаполнения.НаименованиеДляПечати, 
		ДанныеЗаполнения.Наименование);
		
	НоменклатураОбъект.Артикул = ДанныеЗаполнения.Артикул;
	НоменклатураОбъект.Наименование = ДанныеЗаполнения.Наименование;
	НоменклатураОбъект.НаименованиеПолное = НаименованиеПолное;
	НоменклатураОбъект.ЕдиницаИзмерения = СсылкаНаЕдиницуИзмерения;
	НоменклатураОбъект.СтавкаНДС = СтавкаНДС;
	НоменклатураОбъект.Описание = ДанныеЗаполнения.Описание;
	НоменклатураОбъект.ВидНоменклатуры = ДанныеЗаполнения.ВидНоменклатурыПоУмолчанию.ВидНоменклатуры;
	НоменклатураОбъект.ТипНоменклатуры = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(НоменклатураОбъект.ВидНоменклатуры, "ТипНоменклатуры");
	НоменклатураОбъект.АлкогольнаяПродукция = ДанныеЗаполнения.УчастникЕГАИС;
	
	НоменклатураОбъект.ОбменДанными.Загрузка = Истина;
	
	НоменклатураОбъект.Записать();
	
	НоменклатураСсылка = НоменклатураОбъект.Ссылка;
	
КонецПроцедуры

// Создание характеристики с заполнением дополнительных реквизитов.
//
// Параметры:
//  ДанныеЗаполнения     - СтрокаТаблицыЗначений - данные, на основании которых идет заполнение.
//                                                 Описание таблицы значений см. РаботаСНоменклатурой.ДанныеНоменклатурыСервиса, 
//                                                 поле Характеристики
//  Владелец             - Ссылка - ссылка на владельца характеристики.
//  ХарактеристикаСсылка - Ссылка - ссылка на новый элемент.
//
Процедура СоздатьХарактеристикуСДополнительнымиРеквизитами(ДанныеЗаполнения, Владелец, ХарактеристикаСсылка) Экспорт
	
	ЗначенияДополнительныхРеквизитов = Новый ТаблицаЗначений;
	
	ЗначенияДополнительныхРеквизитов.Колонки.Добавить("Свойство");
	ЗначенияДополнительныхРеквизитов.Колонки.Добавить("Значение");
	
	ЗаполнитьЗначенияРеквизитовХарактеристики(
		ЗначенияДополнительныхРеквизитов, 
		ДанныеЗаполнения);
	
	Если ЗначенияДополнительныхРеквизитов.Количество() <> 0 Тогда
		ХарактеристикаСсылка = Неопределено;
		СоздатьХарактеристику(ДанныеЗаполнения, Владелец, ХарактеристикаСсылка);
		УправлениеСвойствами.ЗаписатьСвойстваУОбъекта(ХарактеристикаСсылка, ЗначенияДополнительныхРеквизитов);
	КонецЕсли;
	
КонецПроцедуры

// Создание характеристики.
//
// Параметры:
//  ДанныеЗаполнения     - СтрокаТаблицыЗначений - данные, на основании которых идет заполнение.
//                                                 Описание таблицы значений см. РаботаСНоменклатурой.ДанныеНоменклатурыСервиса, 
//                                                 поле Характеристики.
//  Владелец             - Ссылка - ссылка на владельца характеристики.
//  ХарактеристикаСсылка - Ссылка - ссылка на новый элемент.
//
Процедура СоздатьХарактеристику(ДанныеЗаполнения, Владелец, ХарактеристикаСсылка) Экспорт
	
	НоваяХарактеристика = Справочники.ХарактеристикиНоменклатуры.СоздатьЭлемент();
	НоваяХарактеристика.Владелец = Владелец;
	НоваяХарактеристика.УстановитьНовыйКод();
	НоваяХарактеристика.Наименование = ДанныеЗаполнения.Наименование;
	НоваяХарактеристика.Записать();
	
	ХарактеристикаСсылка = НоваяХарактеристика.Ссылка;
	
КонецПроцедуры

// Создание дополнительных реквизитов номенклатуры.
//
// Параметры:
//  ДанныеЗаполнения - СтрокаТаблицыЗначений - данные, на основании которых идет заполнение.
//                                             Описание таблицы значений см. РаботаСНоменклатурой.ДанныеНоменклатурыСервиса, 
//                                             поле ДополнительныеРеквизиты.
//  НоменклатураСсылка - ЛюбаяСсылка - ссылка на элемент.
//
Процедура ЗаполнитьЗначенияДополнительныхРеквизитов(ДанныеЗаполнения, НоменклатураСсылка) Экспорт
	
	ЗначенияДополнительныхРеквизитов = Новый ТаблицаЗначений;
	
	ЗначенияДополнительныхРеквизитов.Колонки.Добавить("Свойство");
	ЗначенияДополнительныхРеквизитов.Колонки.Добавить("Значение");
	
	Для Каждого ДополнительныйРеквизит Из ДанныеЗаполнения Цикл
		
		Если НЕ ЗначениеЗаполнено(ДополнительныйРеквизит.РеквизитИнформационнойБазы) Тогда
			Продолжить;
		КонецЕсли;	
		
		НоваяСтрока = ЗначенияДополнительныхРеквизитов.Добавить();
		
		НоваяСтрока.Свойство = ДополнительныйРеквизит.РеквизитИнформационнойБазы;
		НоваяСтрока.Значение = РаботаСНоменклатурой.ЗначениеДополнительногоРеквизита(ДополнительныйРеквизит);
		
	КонецЦикла;
	
	Если ЗначенияДополнительныхРеквизитов.Количество() > 0 Тогда
		УправлениеСвойствами.ЗаписатьСвойстваУОбъекта(НоменклатураСсылка, ЗначенияДополнительныхРеквизитов);
	КонецЕсли;
	
КонецПроцедуры

// Сформировать наименование номенклатуры по характеристике.
//
// Параметры:
//  НаименованиеНоменклатуры	 - Строка - текущее наименование объекта.
//  ПредставлениеХарактеристики  - Строка - представление характеристики в сервисе.
//  НаименованиеХарактеристики	 - Строка - итоговое наименование.
//
Процедура СформироватьНаименованиеПоХарактеристике(НаименованиеНоменклатуры, ПредставлениеХарактеристики, НаименованиеХарактеристики) Экспорт
	
	НаименованиеХарактеристики = СтрШаблон("%1 ,%2", НаименованиеНоменклатуры, ПредставлениеХарактеристики);
	
КонецПроцедуры

// Создание значения реквизита.
//
// Параметры:
//  ДополнительныйРеквизит           - ЛюбаяСсылка - ссылка на реквизит.
//  СтрокаДанных                     - СтрокаТаблицыЗначений - строка таблицы значений.
//                                                             Описание таблицы см. РаботаСНоменклатурой.ДанныеКатегорийСервиса, 
//                                                             поле ДополнительныеРеквизиты, колонка Значения.
//  ЗначениеРеквизитаСсылка          - Ссылка - ссылка на новое значение.
//
Процедура СоздатьЗначениеРеквизита(ДополнительныйРеквизит, СтрокаДанных, ЗначениеРеквизитаСсылка) Экспорт
	
	НовоеЗначение = Справочники.ЗначенияСвойствОбъектов.СоздатьЭлемент();
	
	НовоеЗначение.Владелец = ДополнительныйРеквизит;
	НовоеЗначение.Наименование = СтрокаДанных.Наименование;
	НовоеЗначение.ПолноеНаименование = СтрокаДанных.Наименование;
	НовоеЗначение.Записать();
	
	ЗначениеРеквизитаСсылка = НовоеЗначение.Ссылка;
	
КонецПроцедуры

// Создание дополнительного реквизита.
//
// Параметры:
//  ВидНоменклатуры  - СправочникСсылка - ссылка на вид номенклатуры.
//  СтрокаДанных     - Структура, СтрокаТаблицыЗначений - данные для заполнения реквизита.
//                                                        Описание таблицы см. РаботаСНоменклатурой.ДанныеКатегорийСервиса, 
//                                                        поле ДополнительныеРеквизиты.
//  РеквизитСсылка   - ЛюбаяСсылка - ссылка на новый реквизит.
//
Процедура СоздатьДополнительныйРеквизит(ВидНоменклатуры, СтрокаДанных, РеквизитСсылка) Экспорт
	
	
	// Подготовка данных
	
	НаборСвойств = ВидНоменклатуры.НаборСвойств;
	
	УИД = Новый УникальныйИдентификатор();
	СтрокаУИД = СтрЗаменить(Строка(УИД), "-", "");
	ИмяРеквизита = СтрокаДанных.Наименование + "_" + СтрокаУИД;
	
	НаименованиеНабора = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(НаборСвойств, "Наименование");
	Наименование = СтрокаДанных.Наименование + " (" + НаименованиеНабора + ")";
	
	ОписаниеТипа = РаботаСНоменклатурой.ОписаниеТипаНаОснованииТипаСервиса(СтрокаДанных.Тип);
	
	// Заполнение объекта
	
	НовыйРеквизит = ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения.СоздатьЭлемент();
	
	НовыйРеквизит.Наименование = Наименование;
	НовыйРеквизит.Имя          = ИмяРеквизита;
	НовыйРеквизит.Заголовок    = СтрокаДанных.Наименование;
	НовыйРеквизит.НаборСвойств = НаборСвойств;
	НовыйРеквизит.ТипЗначения = ОписаниеТипа;
	НовыйРеквизит.Доступен = Истина;
	
	НовыйРеквизит.Записать();
	
	РеквизитСсылка = НовыйРеквизит.Ссылка;
		
КонецПроцедуры

// Запись штрихкодов в информационную базу. Вызов метода идет в разрезе одной номенклатуры.
//
// Параметры:
//  ДанныеПоШтрихкодам	 - ТаблицаЗначений - данные по штрихкодам.
//  Колонки:
//    * Номенклатура - Ссылка - ссылка на номенклатуру.
//    * Характеристика - Ссылка, Неопределено - ссылка на характеристику.
//    * Штрихкод - Строка - штрихкод.
//
Процедура ЗаписатьШтрихкоды(ДанныеПоШтрихкодам) Экспорт 
	
	//ЕдиницыИзмерения = Новый Соответствие;
	
	Для Каждого ЭлементКоллекции Из ДанныеПоШтрихкодам Цикл
		
		//Если ЕдиницыИзмерения.Получить(ЭлементКоллекции.Номенклатура) = Неопределено Тогда
		//	ЕдиницыИзмерения.Вставить(ЭлементКоллекции.Номенклатура, 
		//		ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ЭлементКоллекции.Номенклатура, "ЕдиницаИзмерения"));
		//КонецЕсли;
		
		МенеджерЗаписи = РегистрыСведений.Штрихкоды.СоздатьМенеджерЗаписи();
		МенеджерЗаписи.Штрихкод = ЭлементКоллекции.Штрихкод;
		МенеджерЗаписи.ПредставлениеШтрихкода = ЭлементКоллекции.Штрихкод;
		МенеджерЗаписи.Владелец = ЭлементКоллекции.Номенклатура;
		МенеджерЗаписи.Характеристика = ЭлементКоллекции.Характеристика;
		МенеджерЗаписи.ТипШтрихкода = ПодключаемоеОборудованиеРТВызовСервера.ОпределитьТипШтрихкода(ЭлементКоллекции.Штрихкод);
		МенеджерЗаписи.Записать(Истина);
		
	КонецЦикла;
	
КонецПроцедуры

// Присвоение новых дополнительных реквизитов виду номенклатуры, которому они должны принадлежать.
//
// Параметры:
//  ВидНоменклатуры         - СправочникСсылка - ссылка на вид номенклатуры.
//  ДополнительныеРеквизиты - Массив - (СправочникСсылка) массив ссылок на новые дополнительные реквизиты.
//  ЯвляетсяРеквизитомХарактеристики - Булево - признак принадлежности реквизитам характеристик. В зависимости от этого
//												параметра, может быть реализован разный алгоритм присвоения.
//
Процедура ПрисвоитьРеквизитыОбъекту(ВидНоменклатуры, ДополнительныеРеквизиты, ЯвляетсяРеквизитомХарактеристики) Экспорт
	
	Если ЯвляетсяРеквизитомХарактеристики Тогда
		НаборСвойств = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ВидНоменклатуры, "НаборСвойствХарактеристик");
	Иначе
		НаборСвойств = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ВидНоменклатуры, "НаборСвойств");
	КонецЕсли;
	
	Если ЗначениеЗаполнено(НаборСвойств) Тогда
		НаборСвойствОбъект = НаборСвойств.ПолучитьОбъект();
		
		Для Каждого ДополнительныйРеквизит Из ДополнительныеРеквизиты Цикл
			
			НоваяСтрокаРеквизита = НаборСвойствОбъект.ДополнительныеРеквизиты.Добавить();
			НоваяСтрокаРеквизита.Свойство = ДополнительныйРеквизит;
			
		КонецЦикла;
		
		НаборСвойствОбъект.Записать();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ФункциональностьСистемы

// Процедура управляет возможностью пакетного создания номенклатуры.
//
// Параметры:
//  РазрешеноПакетноеСоздание - Булево - флаг возможности пакетного создания номенклатуры.
//
Процедура РазрешеноПакетноеСозданиеНоменклатуры(РазрешеноПакетноеСоздание) Экспорт
	
	РазрешеноПакетноеСоздание = Истина;
	
КонецПроцедуры

// Процедура определяет наличие учета характеристик в системе.
//
// Параметры:
//  ИспользоватьХарактеристикиНоменклатуры - Булево - флаг использования характеристик.
//
Процедура ВедетсяУчетПоХарактеристикам(ИспользоватьХарактеристикиНоменклатуры) Экспорт
	
	Результат = ПолучитьФункциональнуюОпцию("ИспользоватьХарактеристикиНоменклатуры");
	
КонецПроцедуры

// Получение признака использования видов номенклатуры в системе. Если виды номенклатуры не используются, не будет
// доступен функционал по работе с дополнительными реквизитами и характеристиками.
//
// Параметры:
//  Результат - Булево - признак использования в системе видов номенклатуры.
//
Процедура ВедетсяУчетВидовНоменклатуры(Результат) Экспорт
	
	Результат = Истина;
	
КонецПроцедуры

#КонецОбласти

#Область ПолучениеДанныхИнформационнойБазы

// Получение значение свойств реквизитов характеристик информационной базы. Метод используется при поиске заведенных в базе
// характеристик. Поиск осуществляется по составу реквизитов и их значениям. Если характеристика с заданным набором
// реквизитов найдена, объект не создается.
//
// Параметры:
//  ВидНоменклатуры                  - СправочникСсылка - вид номенклатуры в разрезе которого
//                                                        анализируются характеристики.
//  ЗначенияХарактеристикТекущейБазы - ТаблицаЗначений - таблица данных информационной базы. Колонки:
//    * ХарактеристикаБазы - Ссылка - ссылка на характеристику.
//    * Свойство           - Ссылка - реквизит характеристики.
//    * Значение           - Произвольный - значение реквизита.
//
Процедура ЗаполнитьТаблицуХарактеристикПоВидуНоменклатуры(ВидНоменклатуры, ЗначенияХарактеристикТекущейБазы) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ХарактеристикиНоменклатурыДополнительныеРеквизиты.Ссылка КАК ХарактеристикаБазы,
	|	ХарактеристикиНоменклатурыДополнительныеРеквизиты.Свойство КАК Свойство,
	|	ХарактеристикиНоменклатурыДополнительныеРеквизиты.Значение КАК Значение
	|ИЗ
	|	Справочник.ХарактеристикиНоменклатуры.ДополнительныеРеквизиты КАК ХарактеристикиНоменклатурыДополнительныеРеквизиты
	|ГДЕ
	|	ХарактеристикиНоменклатурыДополнительныеРеквизиты.Ссылка.Владелец = &ВидНоменклатуры
	|	И НЕ ХарактеристикиНоменклатурыДополнительныеРеквизиты.Ссылка.ПометкаУдаления";
	
	Запрос.УстановитьПараметр("ВидНоменклатуры", ВидНоменклатуры);
	
	ЗначенияХарактеристикТекущейБазы = Запрос.Выполнить().Выгрузить();
	
КонецПроцедуры

// Получение признака использования индивидуальных характеристик вида номенклатуры.
//
// Параметры:
//  ВидНоменклатуры - СправочникСсылка - вид номенклатуры в разрезе которого
//                                       анализируются свойство.
//  Результат - Булево - признак использования индивидуальных характеристик.
//
Процедура ИспользуютсяИндивидуальныеХарактеристики(ВидНоменклатуры, Результат) Экспорт
	
	ИспользованиеХарактеристик = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ВидНоменклатуры, "ИспользованиеХарактеристик");
	Результат = ИспользованиеХарактеристик = Перечисления.ВариантыВеденияДополнительныхДанныхПоНоменклатуре.ИндивидуальныеДляНоменклатуры;
	
КонецПроцедуры

// Получение используемых для вида номенклатуры дополнительных реквизитов.
//
// Параметры:
//  ВидНоменклатуры   - СправочникСсылка - вид номенклатуры в разрезе которого производится поиск данных.
//  ТаблицаРеквизитов - ТаблицаЗначений - таблица реквизитов. Колонки:
//    * РеквизитВидаНоменклатуры              - Ссылка - ссылка дополнительный реквизит.
//    * РеквизитВидаНоменклатурыПредставление - Строка - представление реквизита.
//    * ЯвляетсяХарактеристикой               - Булево - Истина, если реквизит является реквизитом характеристики.
//
Процедура ПолучитьДополнительныеРеквизитыВидаНоменклатуры(ВидНоменклатуры, ТаблицаРеквизитов) Экспорт
	
	Запрос = Новый Запрос;
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ДополнительныеРеквизиты.Свойство КАК РеквизитВидаНоменклатуры,
	|	ЛОЖЬ КАК ЯвляетсяХарактеристикой,
	|	ПРЕДСТАВЛЕНИЕ(ДополнительныеРеквизиты.Свойство) КАК РеквизитВидаНоменклатурыПредставление
	|ИЗ
	|	Справочник.НаборыДополнительныхРеквизитовИСведений.ДополнительныеРеквизиты КАК ДополнительныеРеквизиты
	|ГДЕ
	|	ДополнительныеРеквизиты.Ссылка В
	|			(ВЫБРАТЬ
	|				ВидыНоменклатуры.НаборСвойств КАК НаборСвойств
	|			ИЗ
	|				Справочник.ВидыНоменклатуры КАК ВидыНоменклатуры
	|			ГДЕ
	|				ВидыНоменклатуры.Ссылка = &ВидНоменклатуры)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ДополнительныеРеквизиты.Свойство,
	|	ИСТИНА,
	|	ПРЕДСТАВЛЕНИЕ(ДополнительныеРеквизиты.Свойство)
	|ИЗ
	|	Справочник.НаборыДополнительныхРеквизитовИСведений.ДополнительныеРеквизиты КАК ДополнительныеРеквизиты
	|ГДЕ
	|	ДополнительныеРеквизиты.Ссылка В
	|			(ВЫБРАТЬ
	|				ВидыНоменклатуры.НаборСвойствХарактеристик КАК НаборСвойств
	|			ИЗ
	|				Справочник.ВидыНоменклатуры КАК ВидыНоменклатуры
	|			ГДЕ
	|				ВидыНоменклатуры.Ссылка = &ВидНоменклатуры)";
	
	Запрос.УстановитьПараметр("ВидНоменклатуры", ВидНоменклатуры);
	
	ТаблицаРеквизитов = Запрос.Выполнить().Выгрузить();
	
КонецПроцедуры

// Получение значений реквизитов вида номенклатуры. Используется для выявления расхождений в значениях реквизитов
// объектов информационной базы и объектов сервиса.
//
// Параметры:
//  ВидыНоменклатуры - Ссылка, Массив - виды номенклатуры по которым идет запрос значений реквизитов.
//  Результат        - ТаблицаЗначений - таблица значений реквизитов. Таблица обязательно должна содержать
//                                      колонку с ссылкой на вид номенклатуры и именем ВидНоменклатуры и иметь вид: 
//                                      ВидНоменклатуры, Реквизит1, Реквизит2...Реквизит N.
//
Процедура ПолучитьЗначенияРеквизитовВидовНоменклатуры(Знач ВидыНоменклатуры, Результат) Экспорт
	
	Если ТипЗнч(ВидыНоменклатуры) <> Тип("Массив") Тогда
		ВидыНоменклатуры = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ВидыНоменклатуры);
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ВидыНоменклатуры.Ссылка КАК ВидНоменклатуры,
	|	ВидыНоменклатуры.Наименование КАК Наименование,
	|	ВидыНоменклатуры.ТипНоменклатуры КАК ТипНоменклатуры,
	|	ВидыНоменклатуры.СтавкаНДС КАК СтавкаНДС
	|ИЗ
	|	Справочник.ВидыНоменклатуры КАК ВидыНоменклатуры
	|ГДЕ
	|	ВидыНоменклатуры.Ссылка В(&ВидыНоменклатуры)";
	
	Запрос.УстановитьПараметр("ВидыНоменклатуры", ВидыНоменклатуры);
	
	Результат = Запрос.Выполнить().Выгрузить();
	
КонецПроцедуры

// Получение значений реквизитов номенклатуры. Используется для выявления расхождений в значениях реквизитов
// объектов информационной базы и объектов сервиса.
//
// Параметры:
//  Номенклатура - Ссылка, Массив - номенклатура по которым идет запрос значений реквизитов.
//  Результат       - ТаблицаЗначений - таблица значений реквизитов. Таблица обязательно должна содержать
//                                      колонку с ссылкой на номенклатуру и именем Номенклатура и иметь вид: 
//                                      Номенклатура, Реквизит1, Реквизит2...Реквизит N.
//
Процедура ПолучитьЗначенияРеквизитовНоменклатуры(Знач Номенклатура, Результат) Экспорт
	
	Если ТипЗнч(Номенклатура) <> Тип("Массив") Тогда
		Номенклатура = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Номенклатура);
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Номенклатура.Артикул КАК Артикул,
	|	Номенклатура.Наименование КАК Наименование,
	|	Номенклатура.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
	|	Номенклатура.СтавкаНДС КАК СтавкаНДС,
	|	Номенклатура.Ссылка КАК Номенклатура,
	|	Номенклатура.ВидНоменклатуры КАК ВидНоменклатуры,
	|	Номенклатура.ТипНоменклатуры КАК ТипНоменклатуры,
	|	Номенклатура.АлкогольнаяПродукция КАК АлкогольнаяПродукция,
	|	Номенклатура.Описание КАК Описание
	|ИЗ
	|	Справочник.Номенклатура КАК Номенклатура
	|ГДЕ
	|	Номенклатура.Ссылка В(&Номенклатура)";
	
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	
	Результат = Запрос.Выполнить().Выгрузить();
	
КонецПроцедуры

// Получение значений дополнительных реквизитов номенклатуры.
//
// Параметры:
//  Номенклатура         - Массив - (Ссылка) массив ссылок номенклатуры.
//  ЗначенияРеквизитов	 - ТаблицаЗначений - заполняемые данные значений свойство.
//    * ВладелецСвойств - Ссылка - ссылка на номенклатуру.
//    * Свойство - Ссылка - свойство номенклатуры.
//    * Значение - Произвольный - значение свойства.
//
Процедура ПолучитьЗначенияДополнительныхРеквизитов(Номенклатура, ЗначенияРеквизитов) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	НоменклатураДополнительныеРеквизиты.Ссылка КАК ВладелецСвойств,
	|	НоменклатураДополнительныеРеквизиты.Свойство КАК Свойство,
	|	НоменклатураДополнительныеРеквизиты.Значение КАК Значение
	|ИЗ
	|	Справочник.Номенклатура.ДополнительныеРеквизиты КАК НоменклатураДополнительныеРеквизиты
	|ГДЕ
	|	НоменклатураДополнительныеРеквизиты.Ссылка В(&Номенклатура)";
	
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	
	ЗначенияРеквизитов = Запрос.Выполнить().Выгрузить();
	
КонецПроцедуры

// Получение вида номенклатуры по номенклатуре.
//
// Параметры:
//  НоменклатураСсылка   - Ссылка - номенклатура.
//  ВидНоменклатуры	     - Ссылка - вид номенклатуры.
//
Процедура ПолучитьВидНоменклатуры(НоменклатураСсылка, ВидНоменклатуры) Экспорт
	
	ВидНоменклатуры = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(НоменклатураСсылка, "ВидНоменклатуры");
	
КонецПроцедуры

// Получение вида номенклатуры из формы номенклатуры.
//
// Параметры:
//  Форма				 - УправляемаяФорма - форма номенклатуры.
//  ВидНоменклатуры	     - Ссылка - вид номенклатуры.
//
Процедура ПолучитьВидНоменклатурыИзФормы(Форма, ВидНоменклатуры) Экспорт
	
	ВидНоменклатуры = Форма.Объект.ВидНоменклатуры;
	
КонецПроцедуры

// Получение значений реквизитов из формы.
//
// Параметры:
//  Форма				 - УправляемаяФорма - форма номенклатуры.
//  ЗначенияРеквизитов	 - Структура - структура, где ключ - имя реквизита, значение - значение реквизита.
//
Процедура ПолучитьЗначенияРеквизитовНоменклатурыИзФормы(Форма, ЗначенияРеквизитов) Экспорт
	
	ЗначенияРеквизитов.Вставить("Артикул");
	ЗначенияРеквизитов.Вставить("Наименование");
	ЗначенияРеквизитов.Вставить("ЕдиницаИзмерения");
	ЗначенияРеквизитов.Вставить("СтавкаНДС");
	ЗначенияРеквизитов.Вставить("ВидНоменклатуры");
	ЗначенияРеквизитов.Вставить("ТипНоменклатуры");
	ЗначенияРеквизитов.Вставить("АлкогольнаяПродукция");
	ЗначенияРеквизитов.Вставить("Описание");
	
	Для каждого ЭлементКоллекции Из ЗначенияРеквизитов Цикл
		ЗначенияРеквизитов[ЭлементКоллекции.Ключ] = Форма.Объект[ЭлементКоллекции.Ключ];
	КонецЦикла;
	
КонецПроцедуры

// Получение значений дополнительных реквизитов из формы.
//
// Параметры:
//  Форма				 - УправляемаяФорма - форма номенклатуры.
//  ЗначенияРеквизитов	 - ТаблицаЗначений - таблица значений дополнительных реквизитов. Колонки:
//    * Свойство           - Ссылка - дополнительный реквизит.
//    * Значение           - Произвольный - значение реквизита.
//
Процедура ПолучитьЗначенияДополнительныхРеквизитовИзФормы(Форма, ЗначенияРеквизитов) Экспорт
	
	УправлениеСвойствами.ПеренестиЗначенияИзРеквизитовФормыВОбъект(Форма,Форма.Объект);
	
	ЗначенияРеквизитов = Форма.Объект.ДополнительныеРеквизиты.Выгрузить(, "Свойство, Значение");
	
КонецПроцедуры

#КонецОбласти

#Область ПриПолученииДанныхИзСервиса

// Процедура вызывается после получения данных номенклатуры из сервиса. Может использоваться
// для предварительной подготовки данных информационной базы 
// перед созданием, сравнением, заполнением объектов. Например на этом этапе можно 
// создать бренды, производителей, единицы измерения и так далее.
//
// Параметры:
//  ДанныеПоНоменклатуре - ТаблицаЗначений - см. РаботаСНоменклатурой.ДанныеНоменклатурыСервиса.
//
Процедура ПриПолученииДанныхИзСервисаПоНоменклатуре(ДанныеПоНоменклатуре) Экспорт
	
КонецПроцедуры

// Процедура вызывается после получения данных категорий из сервиса. Может использоваться
// для предварительной подготовки данных информационной базы 
// перед созданием, сравнением, заполнением объектов.
//
// Параметры:
//  ДанныеПоКатегориям - ТаблицаЗначений - см. РаботаСНоменклатурой.ДанныеКатегорийСервиса.
//
Процедура ПриПолученииДанныхИзСервисаПоКатегориям(ДанныеПоКатегориям) Экспорт
	
КонецПроцедуры

#КонецОбласти

#Область СопоставлениеДанных

// Сравнение значений реквизитов вида номенклатуры и категории.
//
// Параметры:
//  ДанныеКатегории       - СтрокаТаблицыЗначений - данные по категории. Описание таблицы значений см. РаботаСНоменклатурой.ДанныеКатегорийСервиса
//  ДанныеВидаНоменклатуры - СтрокаТаблицыЗначений, Структура, Ссылка - данные по виду номенклатуре. См. ПолучитьЗначенияРеквизитовВидовНоменклатуры
//  ТаблицаОтличийРеквизитов - ТаблицаЗначений - см. РаботаСНоменклатурой.ТаблицаОтличийРеквизитов.
//
Процедура ПолучитьОтличияВидаНоменклатурыИКатегории(ДанныеКатегории, ДанныеВидаНоменклатуры, ТаблицаОтличийРеквизитов) Экспорт
	
	// Проверка наименования
	Если ДанныеВидаНоменклатуры.Наименование <> ДанныеКатегории.Наименование Тогда
		РаботаСНоменклатурой.ДобавитьСтрокуВТаблицуОтличий(ТаблицаОтличийРеквизитов, 
			"Наименование", ДанныеКатегории.Наименование, ДанныеВидаНоменклатуры.Наименование);
	КонецЕсли; 
	
	// Проверка ставки НДС
	СтавкаНДССервиса = Перечисления.СтавкиНДС.ПустаяСсылка();
	ПреобразоватьСтавкуНДССервиса(ДанныеКатегории.СтавкаНДС, СтавкаНДССервиса);
	
	Если ДанныеВидаНоменклатуры.СтавкаНДС <> СтавкаНДССервиса Тогда
		РаботаСНоменклатурой.ДобавитьСтрокуВТаблицуОтличий(ТаблицаОтличийРеквизитов, 
			"СтавкаНДС", СтавкаНДССервиса, ДанныеВидаНоменклатуры.СтавкаНДС, НСтр("ru = 'Ставка НДС'"));
	КонецЕсли; 
	
	// Проверка типа номенклатуры
	ТипНоменклатурыСервиса = Перечисления.ТипыНоменклатуры.ПустаяСсылка();
	ПреобразоватьТипНоменклатурыСервиса(ДанныеКатегории.Тип, ТипНоменклатурыСервиса);
	
	Если ДанныеВидаНоменклатуры.ТипНоменклатуры <> ТипНоменклатурыСервиса Тогда
		РаботаСНоменклатурой.ДобавитьСтрокуВТаблицуОтличий(ТаблицаОтличийРеквизитов, 
			"ТипНоменклатуры", ТипНоменклатурыСервиса, ДанныеВидаНоменклатуры.ТипНоменклатуры, НСтр("ru = 'Тип номенклатуры'"));
	КонецЕсли; 
	
КонецПроцедуры

// Сравнение значений реквизитов номенклатуры информационной базы и номенклатуры сервиса.
//
// Параметры:
//  ДанныеНоменклатурыСервиса - СтрокаТаблицыЗначений - данные по номенклатуре. Описание таблицы значений см. РаботаСНоменклатурой.ДанныеНоменклатурыСервиса.
//  ДанныеНоменклатурыБазы    - СтрокаТаблицыЗначений, Структура, Ссылка - данные по номенклатуре. См. ПолучитьЗначенияРеквизитовНоменклатуры
//  ТаблицаОтличийРеквизитов  - ТаблицаЗначений - см. РаботаСНоменклатурой.ТаблицаОтличийРеквизитов.
//
Процедура ПолучитьОтличияНоменклатуры(ДанныеКатегории, ДанныеВидаНоменклатуры, ТаблицаОтличийРеквизитов) Экспорт
	
	// Проверка наименования
	Если ДанныеВидаНоменклатуры.Наименование <> ДанныеКатегории.Наименование Тогда
		РаботаСНоменклатурой.ДобавитьСтрокуВТаблицуОтличий(ТаблицаОтличийРеквизитов, 
			"Наименование", ДанныеКатегории.Наименование, ДанныеВидаНоменклатуры.Наименование);
	КонецЕсли; 
	
	// Проверка вида номенклатуры
	
	ВидыНоменклатуры = РаботаСНоменклатурой.ВидыНоменклатурыПоИдентификаторуКатегории(ДанныеКатегории.Категория.Идентификатор);
	
	Если ВидыНоменклатуры.Количество() Тогда
		Если ВидыНоменклатуры[0] <> ДанныеВидаНоменклатуры.ВидНоменклатуры Тогда 
			РаботаСНоменклатурой.ДобавитьСтрокуВТаблицуОтличий(ТаблицаОтличийРеквизитов,
			"ВидНоменклатуры", ВидыНоменклатуры[0], ДанныеВидаНоменклатуры.ВидНоменклатуры, НСтр("ru = 'Вид номенклатуры'"), ДанныеКатегории.Категория.Наименование);
		КонецЕсли;
	КонецЕсли;
		
	// Проверка единицы измерения
	ЕдиницаИзмеренияСервиса = ДанныеКатегории.ЕдиницаИзмерения;
	Если Строка(ДанныеКатегории.ЕдиницаИзмерения.Наименование) <> ДанныеВидаНоменклатуры.ЕдиницаИзмерения.Наименование Тогда
		
		ЕдиницаИзмеренияВБазе = Неопределено;
		ЕдиницаИзмеренияВБазе(ЕдиницаИзмеренияСервиса, ЕдиницаИзмеренияВБазе);
		Если Не ЗначениеЗаполнено(ЕдиницаИзмеренияВБазе) Тогда 
			ЕдиницаИзмеренияПоДаннымСервиса(ЕдиницаИзмеренияСервиса, ЕдиницаИзмеренияВБазе)
		КонецЕсли;
		
		РаботаСНоменклатурой.ДобавитьСтрокуВТаблицуОтличий(ТаблицаОтличийРеквизитов, 
			"ЕдиницаИзмерения",  ЕдиницаИзмеренияВБазе, ДанныеВидаНоменклатуры.ЕдиницаИзмерения.Наименование, НСтр("ru = 'Единица измерения'"), ЕдиницаИзмеренияСервиса.Наименование);
	КонецЕсли; 
	
	// Проверка ставки НДС
	СтавкаНДССервиса = Перечисления.СтавкиНДС.ПустаяСсылка();
	ПреобразоватьСтавкуНДССервиса(ДанныеКатегории.СтавкаНДС, СтавкаНДССервиса);
	
	Если ДанныеВидаНоменклатуры.СтавкаНДС <> СтавкаНДССервиса Тогда
		РаботаСНоменклатурой.ДобавитьСтрокуВТаблицуОтличий(ТаблицаОтличийРеквизитов,
			"СтавкаНДС", СтавкаНДССервиса, ДанныеВидаНоменклатуры.СтавкаНДС, НСтр("ru = 'Ставка НДС'"));
	КонецЕсли; 
	
	// Проверка типа номенклатуры
	ТипНоменклатурыСервиса = Перечисления.ТипыНоменклатуры.ПустаяСсылка();
	ПреобразоватьТипНоменклатурыСервиса(ДанныеКатегории.Тип, ТипНоменклатурыСервиса);
	
	Попытка
		Если ТипЗнч(ДанныеВидаНоменклатуры) = Тип("Структура")
			И ДанныеВидаНоменклатуры.Свойство("ТипНоменклатуры")
			И ДанныеВидаНоменклатуры.ТипНоменклатуры <> ТипНоменклатурыСервиса Тогда
			РаботаСНоменклатурой.ДобавитьСтрокуВТаблицуОтличий(ТаблицаОтличийРеквизитов, 
				"ТипНоменклатуры", ТипНоменклатурыСервиса, ДанныеВидаНоменклатуры.ТипНоменклатуры, НСтр("ru = 'Тип номенклатуры'"));
		КонецЕсли;
	Исключение
		СтрокаОшибки = ОписаниеОшибки();
	КонецПопытки;
	
КонецПроцедуры

#КонецОбласти

#Область ЗаполнениеДанных

// Заполнение реквизитов вида номенклатуры.
//
// Параметры:
//  ВидНоменклатурыСсылка - СправочникСсылка - ссылка на вид номенклатуры.
//  ТаблицаИзменений      - ТаблицаЗначений - реквизиты и значения для записи. Таблица должна быть 
//                                            сформирована в методе ПолучитьОтличияВидаНоменклатурыИКатегории.
//                                            см. РаботаСНоменклатурой.ТаблицаОтличийРеквизитов.
//
Процедура ЗаполнитьВидНоменклатуры(ВидНоменклатурыСсылка, ТаблицаИзменений) Экспорт
	
	Если ТаблицаИзменений.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ВидНоменклатурыОбъект = ВидНоменклатурыСсылка.ПолучитьОбъект();
	
	ЗаблокироватьДанныеДляРедактирования(ВидНоменклатурыОбъект.Ссылка);
	
	Для каждого ЭлементКоллекции Из ТаблицаИзменений Цикл
		ВидНоменклатурыОбъект[ЭлементКоллекции.РеквизитОбъекта] = ЭлементКоллекции.НовоеЗначение;
	КонецЦикла;
	
	ВидНоменклатурыОбъект.Записать();
	
КонецПроцедуры

// Заполнение реквизитов номенклатуры.
//
// Параметры:
//  НоменклатураСсылка - СправочникСсылка - ссылка на номенклатуру.
//  ТаблицаИзменений   - ТаблицаЗначений - реквизиты и значения для записи. Таблица должна быть 
//                                         сформирована в методе ПолучитьОтличияНоменклатуры.
//                                         см. РаботаСНоменклатурой.ТаблицаОтличийРеквизитов.
//
Процедура ЗаполнитьНоменклатуру(НоменклатураСсылка, ТаблицаИзменений) Экспорт
	
	Если ТаблицаИзменений.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	НоменклатураОбъект = НоменклатураСсылка.ПолучитьОбъект();
	
	ЗаблокироватьДанныеДляРедактирования(НоменклатураОбъект.Ссылка);
	
	Для каждого ЭлементКоллекции Из ТаблицаИзменений Цикл
		НоменклатураОбъект[ЭлементКоллекции.РеквизитОбъекта] = ЭлементКоллекции.НовоеЗначение;
	КонецЦикла;
	
	НоменклатураОбъект.Записать();
	
КонецПроцедуры

// Заполнение дополнительных реквизитов номенклатуры.
//
// Параметры:
//  НоменклатураСсылка      - Ссылка - ссылка на номенклатуру.
//  ДополнительныеРеквизиты - ТаблицаЗначений - реквизиты для записи в структуре:
//    * РеквизитОбъекта - Ссылка - свойство реквизита.
//    * НовоеЗначение   - Произвольный - значение реквизита.
//
Процедура ЗаполнитьДополнительныеРеквизитыНоменклатуры(НоменклатураСсылка, ДополнительныеРеквизиты) Экспорт
	
	Если ДополнительныеРеквизиты.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ЗначенияДополнительныхРеквизитов = Новый ТаблицаЗначений;
	
	ЗначенияДополнительныхРеквизитов.Колонки.Добавить("Свойство");
	ЗначенияДополнительныхРеквизитов.Колонки.Добавить("Значение");
	
	Для каждого Реквизит Из ДополнительныеРеквизиты Цикл
		
		НоваяСтрока = ЗначенияДополнительныхРеквизитов.Добавить();
		
		НоваяСтрока.Свойство = Реквизит.РеквизитОбъекта;
		НоваяСтрока.Значение = Реквизит.НовоеЗначение;
		
	КонецЦикла;
	
	УправлениеСвойствами.ЗаписатьСвойстваУОбъекта(НоменклатураСсылка, ЗначенияДополнительныхРеквизитов);
	
КонецПроцедуры

// Интерактивное заполнение основных реквизитов номенклатуры.
//
// Параметры:
//  Форма                 - УправляемаяФорма - форма номенклатуры.
//  ТаблицаИзменений      - ТаблицаЗначений - реквизиты и значения для записи. Таблица должна быть 
//                                            сформирована в методе ПолучитьОтличияВидаНоменклатурыИКатегории.
//                                            см. РаботаСНоменклатурой.ТаблицаОтличийРеквизитов.
//
Процедура ЗаполнитьНоменклатуруВФорме(Форма, ТаблицаИзменений) Экспорт
	
	Если ТаблицаИзменений.Количество() > 0 Тогда
		Форма.Модифицированность = Истина;
	Иначе
		Возврат;
	КонецЕсли;
	
	Для каждого ЭлементКоллекции Из ТаблицаИзменений Цикл
		Форма.Объект[ЭлементКоллекции.РеквизитОбъекта] = ЭлементКоллекции.НовоеЗначение;
	КонецЦикла;
	
КонецПроцедуры

// Интерактивное заполнение дополнительных реквизитов номенклатуры.
//
// Параметры:
//  Форма                 - УправляемаяФорма - форма номенклатуры.
//  ТаблицаИзменений      - ТаблицаЗначений - реквизиты и значения для записи. Таблица должна быть 
//                                            сформирована в методе ПолучитьОтличияВидаНоменклатурыИКатегории.
//                                            см. РаботаСНоменклатурой.ТаблицаОтличийРеквизитов.
//
Процедура ЗаполнитьДополнительныеРеквизитыНоменклатурыВФорме(Форма, ТаблицаИзменений) Экспорт
	
	Если ТаблицаИзменений.Количество() > 0 Тогда
		Форма.Модифицированность = Истина;
	Иначе
		Возврат;
	КонецЕсли;
	
	Объект = Форма.Объект;
	
	Для Каждого ЭлементКоллекции Из ТаблицаИзменений Цикл
		
		СтрокиРеквизита = Объект.ДополнительныеРеквизиты.
			НайтиСтроки(Новый Структура("Свойство", ЭлементКоллекции.РеквизитОбъекта));
		
		Если СтрокиРеквизита.Количество() = 0 Тогда
			НоваяСтрока = Объект.ДополнительныеРеквизиты.Добавить();
			НоваяСтрока.Свойство = ЭлементКоллекции.РеквизитОбъекта;
			НоваяСтрока.Значение = ЭлементКоллекции.НовоеЗначение;
		Иначе
			СтрокиРеквизита[0].Значение = ЭлементКоллекции.НовоеЗначение;
		КонецЕсли;
		
	КонецЦикла;
	
	УправлениеСвойствами.ЗаполнитьДополнительныеРеквизитыВФорме(Форма, Объект);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеФункцииИПроцедуры

Процедура ПреобразоватьСтавкуНДССервиса(Знач Значение, Ссылка)
	
	Если Значение = "10" Тогда
		Ссылка = Перечисления.СтавкиНДС.НДС10;
	ИначеЕсли Значение = "18" Тогда
		Ссылка = Перечисления.СтавкиНДС.НДС18;
	ИначеЕсли Значение = "20" Тогда
		Ссылка = Перечисления.СтавкиНДС.НДС20;
	Иначе
		Ссылка = Перечисления.СтавкиНДС.БезНДС;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПреобразоватьТипНоменклатурыСервиса(Знач Значение, Результат)

	Если Значение = "Услуга" Тогда 
		Результат = Перечисления.ТипыНоменклатуры.Услуга;
	ИначеЕсли Значение = "Товар" Тогда 
		Результат = Перечисления.ТипыНоменклатуры.Товар;
	Иначе 
		Результат = Перечисления.ТипыНоменклатуры.ПустаяСсылка();
	КонецЕсли;
	
КонецПроцедуры

Процедура ЕдиницаИзмеренияПоДаннымСервиса(ЕдиницаИзмеренияСервиса, ЕдиницаИзмеренияСсылка) 
	
	// Поиск элемента в базе
	
	ЕдиницаИзмеренияВБазе(ЕдиницаИзмеренияСервиса, ЕдиницаИзмеренияСсылка);
	
	Если ЗначениеЗаполнено(ЕдиницаИзмеренияСсылка) Тогда
		Возврат;
	КонецЕсли;
	
	// Создание элемента если не найдено
	
	ЕдиницаИзмеренияОбъект = Справочники.БазовыеЕдиницыИзмерения.СоздатьЭлемент();
	
	ЕдиницаИзмеренияОбъект.Наименование = СокрЛП(ЕдиницаИзмеренияСервиса.Наименование);
	
	Если ЕдиницаИзмеренияСервиса.Свойство("ОКЕИ") Тогда
		ЕдиницаИзмеренияОбъект.Код = ЕдиницаИзмеренияСервиса.ОКЕИ;
	КонецЕсли;
	ЕдиницаИзмеренияОбъект.Записать();
	
	ЕдиницаИзмеренияСсылка = ЕдиницаИзмеренияОбъект.Ссылка;
	
КонецПроцедуры

Процедура ЕдиницаИзмеренияВБазе(ЕдиницаИзмеренияСервиса, ЕдиницаИзмеренияСсылка)
	
	СсылкаНаЕдиницуИзмерения = Неопределено;
	
	Если ЕдиницаИзмеренияСервиса.Свойство("ОКЕИ")
		И ЗначениеЗаполнено(ЕдиницаИзмеренияСервиса.ОКЕИ) Тогда
		СсылкаНаЕдиницуИзмерения = Справочники.БазовыеЕдиницыИзмерения.НайтиПоКоду(ЕдиницаИзмеренияСервиса.ОКЕИ);
	Иначе
		
		НаименованиеЕдиницыИзмерения = СокрЛП(ЕдиницаИзмеренияСервиса.Наименование);
		Если НЕ ЗначениеЗаполнено(НаименованиеЕдиницыИзмерения) Тогда
			Возврат;
		КонецЕсли;
		СсылкаНаЕдиницуИзмерения = Справочники.БазовыеЕдиницыИзмерения.НайтиПоНаименованию(НаименованиеЕдиницыИзмерения);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(СсылкаНаЕдиницуИзмерения) Тогда
		ЕдиницаИзмеренияСсылка = СсылкаНаЕдиницуИзмерения;
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗаполнитьЗначенияРеквизитовХарактеристики(ЗначенияДополнительныхРеквизитов, Характеристика)
	
	ЗначенияДополнительныхРеквизитов.Очистить();
	
	Для Каждого Свойство Из Характеристика.ДополнительныеРеквизиты Цикл
		
		Если Не ЗначениеЗаполнено(Свойство.РеквизитИнформационнойБазы) Тогда
			Продолжить;
		КонецЕсли;
		
		НоваяСтрока = ЗначенияДополнительныхРеквизитов.Добавить();
		
		НоваяСтрока.Свойство = Свойство.РеквизитИнформационнойБазы;
		НоваяСтрока.Значение = РаботаСНоменклатурой.ЗначениеДополнительногоРеквизита(Свойство);
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
