﻿////////////////////////////////////////////////////////////////////////////////
// Обновление информационной базы библиотеки интеграции с ГИСМ.
// 
/////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

////////////////////////////////////////////////////////////////////////////////
// Получение сведений о библиотеке (или конфигурации).

// См. процедуру ОбновлениеИнформационнойБазыБСП.ПриДобавленииПодсистемы
Процедура ПриДобавленииПодсистемы(Описание) Экспорт
	
	Описание.Имя    = "БиблиотекаСистемыМаркировки";
	Описание.Версия = "1.0.4.1";
	Описание.РежимВыполненияОтложенныхОбработчиков = "Параллельно";
	
	Описание.ТребуемыеПодсистемы.Добавить("СтандартныеПодсистемы");
	Описание.ТребуемыеПодсистемы.Добавить("БиблиотекаПодключаемогоОборудования");
	
КонецПроцедуры

// См. процедуру ОбновлениеИнформационнойБазыБСП.ПриДобавленииОбработчиковОбновления
Процедура ПриДобавленииОбработчиковОбновления(Обработчики) Экспорт
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "1.0.1.5";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыГИСМ.НачальноеЗаполнение";
	Обработчик.НачальноеЗаполнение = Истина;
	Обработчик.РежимВыполнения = "Монопольно";
	Обработчик.Комментарий = НСтр("ru = 'Заполнение версии схем обмена с ГИСМ.'");
	
КонецПроцедуры

// См. процедуру ОбновлениеИнформационнойБазыБСП.ПередОбновлениемИнформационнойБазы
Процедура ПередОбновлениемИнформационнойБазы() Экспорт
	
	ИдентификаторБиблиотекаИнтеграцииГИСМ = "БиблиотекаИнтеграцииГИСМ";
	ВерсияБиблиотекаИнтеграцииГИСМ = ОбновлениеИнформационнойБазы.ВерсияИБ(ИдентификаторБиблиотекаИнтеграцииГИСМ);
	Если ВерсияБиблиотекаИнтеграцииГИСМ <> "0.0.0.0" Тогда
		
		ОбновлениеИнформационнойБазы.УстановитьВерсиюИБ("БиблиотекаСистемыМаркировки", ВерсияБиблиотекаИнтеграцииГИСМ, Ложь);
		
		Если ОбщегоНазначения.РазделениеВключено() Тогда
			ИмяРегистра = "ВерсииПодсистемОбластейДанных";
		Иначе
			ИмяРегистра = "ВерсииПодсистем";
		КонецЕсли;
		
		Набор = РегистрыСведений[ИмяРегистра].СоздатьНаборЗаписей();
		Набор.Отбор.ИмяПодсистемы.Установить(ИдентификаторБиблиотекаИнтеграцииГИСМ);
		Набор.Записать();
		
	КонецЕсли;
	
КонецПроцедуры

// См. процедуру ОбновлениеИнформационнойБазыБСП.ПослеОбновленияИнформационнойБазы
Процедура ПослеОбновленияИнформационнойБазы(Знач ПредыдущаяВерсия, Знач ТекущаяВерсия,
		Знач ВыполненныеОбработчики, ВыводитьОписаниеОбновлений, МонопольныйРежим) Экспорт
	
КонецПроцедуры

// См. процедуру ОбновлениеИнформационнойБазыБСП.ПриПодготовкеМакетаОписанияОбновлений
Процедура ПриПодготовкеМакетаОписанияОбновлений(Знач Макет) Экспорт
	

КонецПроцедуры

// Позволяет переопределить режим обновления данных информационной базы.
// Для использования в редких (нештатных) случаях перехода, не предусмотренных в
// стандартной процедуре определения режима обновления.
//
// Параметры:
//   РежимОбновленияДанных - Строка - в обработчике можно присвоить одно из значений:
//              "НачальноеЗаполнение"     - если это первый запуск пустой базы (области данных);
//              "ОбновлениеВерсии"        - если выполняется первый запуск после обновление конфигурации базы данных;
//              "ПереходСДругойПрограммы" - если выполняется первый запуск после обновление конфигурации базы данных, 
//                                          в которой изменилось имя основной конфигурации.
//
//   СтандартнаяОбработка  - Булево - если присвоить Ложь, то стандартная процедура
//                                    определения режима обновления не выполняется, 
//                                    а используется значение РежимОбновленияДанных.
//
Процедура ПриОпределенииРежимаОбновленияДанных(РежимОбновленияДанных, СтандартнаяОбработка) Экспорт
 
КонецПроцедуры

// Добавляет в список процедуры-обработчики перехода с другой программы (с другим именем конфигурации).
// Например, для перехода между разными, но родственными конфигурациями: базовая -> проф -> корп.
// Вызывается перед началом обновления данных ИБ.
//
// Параметры:
//  Обработчики - ТаблицаЗначений - с колонками:
//    * ПредыдущееИмяКонфигурации - Строка - имя конфигурации, с которой выполняется переход;
//                                           или "*", если нужно выполнять при переходе с любой конфигурации.
//    * Процедура                 - Строка - полное имя процедуры-обработчика перехода с программы ПредыдущееИмяКонфигурации. 
//                                  Например, "ОбновлениеИнформационнойБазыУПП.ЗаполнитьУчетнуюПолитику"
//                                  Обязательно должна быть экспортной.
//
// Пример добавления процедуры-обработчика в список:
//  Обработчик = Обработчики.Добавить();
//  Обработчик.ПредыдущееИмяКонфигурации  = "УправлениеТорговлей";
//  Обработчик.Процедура                  = "ОбновлениеИнформационнойБазыУПП.ЗаполнитьУчетнуюПолитику";
//
Процедура ПриДобавленииОбработчиковПереходаСДругойПрограммы(Обработчики) Экспорт
 
КонецПроцедуры

// Вызывается после выполнения всех процедур-обработчиков перехода с другой программы (с другим именем конфигурации),
// и до начала выполнения обновления данных ИБ.
//
// Параметры:
//  ПредыдущееИмяКонфигурации    - Строка - имя конфигурации до перехода.
//  ПредыдущаяВерсияКонфигурации - Строка - имя предыдущей конфигурации (до перехода).
//  Параметры                    - Структура - 
//    * ВыполнитьОбновлениеСВерсии   - Булево - по умолчанию Истина. Если установить Ложь, 
//        то будут выполнена только обязательные обработчики обновления (с версией "*").
//    * ВерсияКонфигурации           - Строка - номер версии после перехода. 
//        По умолчанию, равен значению версии конфигурации в свойствах метаданных.
//        Для того чтобы выполнить, например, все обработчики обновления с версии ПредыдущаяВерсияКонфигурации, 
//        следует установить значение параметра в ПредыдущаяВерсияКонфигурации.
//        Для того чтобы выполнить вообще все обработчики обновления, установить значение "0.0.0.1".
//    * ОчиститьСведенияОПредыдущейКонфигурации - Булево - по умолчанию Истина. 
//        Для случаев когда предыдущая конфигурация совпадает по имени с подсистемой текущей конфигурации, следует указать Ложь.
//
Процедура ПриЗавершенииПереходаСДругойПрограммы(Знач ПредыдущееИмяКонфигурации, Знач ПредыдущаяВерсияКонфигурации, Параметры) Экспорт
 
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ПервоначальноеЗаполнениеИОбновлениеИнформационнойБазы

Процедура НачальноеЗаполнение() Экспорт
	
	ИнтеграцияГИСМ.ПроверитьОбновитьВерсиюСхемОбмена(ИнтеграцияГИСМ.ВерсияСхемОбменаПоУмолчанию());
	
КонецПроцедуры

#КонецОбласти

#Область ОбновлениеИнформационнойБазы_ВерсииСхемОбменаГИСМ

Процедура ВерсииСхемОбменаГИСМ_ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ОбработкаЗавершена = Ложь;
	
	НачатьТранзакцию();
	Попытка
		
		Блокировка = Новый БлокировкаДанных;
		ЭлементБлокировки = Блокировка.Добавить("Константа.ВерсииСхемОбменаГИСМ");
		ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
		Блокировка.Заблокировать();
		
		Если ПолучитьФункциональнуюОпцию("ВестиУчетМаркировкиПродукцииВГИСМ") Тогда
			
			НоваяВерсия = ИнтеграцияГИСМВызовСервера.АктуальнаяВерсияСхемОбмена();
			
			Если ЗначениеЗаполнено(НоваяВерсия) Тогда
				ИнтеграцияГИСМ.ПроверитьОбновитьВерсиюСхемОбмена(НоваяВерсия);
			Иначе
				ИнтеграцияГИСМ.ПроверитьОбновитьВерсиюСхемОбмена(ИнтеграцияГИСМ.ВерсияСхемОбменаПоУмолчанию());
			КонецЕсли;
			
		Иначе
			
			ИнтеграцияГИСМ.ПроверитьОбновитьВерсиюСхемОбмена(ИнтеграцияГИСМ.ВерсияСхемОбменаПоУмолчанию());
			
		КонецЕсли;
		
		ЗафиксироватьТранзакцию();
		
		ОбработкаЗавершена = Истина;
		
	Исключение
		
		ОтменитьТранзакцию();
		
		ТекстСообщения = НСтр("ru = 'Не удалось обработать константу ВерсииСхемОбменаГИСМ по причине: %Причина%'");
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Причина%", ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(),
			УровеньЖурналаРегистрации.Предупреждение,
			Метаданные.Константы.ВерсииСхемОбменаГИСМ,,
			ТекстСообщения);
		
	КонецПопытки;
	
	Параметры.ОбработкаЗавершена = ОбработкаЗавершена;
	
КонецПроцедуры

Процедура ВерсииСхемОбменаГИСМ_ВерсияСхемОбменаПоУмолчанию_ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ОбработкаЗавершена = Ложь;
	
	НачатьТранзакцию();
	Попытка
		
		Блокировка = Новый БлокировкаДанных;
		ЭлементБлокировки = Блокировка.Добавить("Константа.ВерсииСхемОбменаГИСМ");
		ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
		Блокировка.Заблокировать();
		
		ИнтеграцияГИСМ.ПроверитьОбновитьВерсиюСхемОбмена(ИнтеграцияГИСМ.ВерсияСхемОбменаПоУмолчанию());
		
		ЗафиксироватьТранзакцию();
		
		ОбработкаЗавершена = Истина;
		
	Исключение
		
		ОтменитьТранзакцию();
		
		ТекстСообщения = НСтр("ru = 'Не удалось обработать константу ВерсииСхемОбменаГИСМ по причине: %Причина%'");
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Причина%", ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(),
			УровеньЖурналаРегистрации.Предупреждение,
			Метаданные.Константы.ВерсииСхемОбменаГИСМ,,
			ТекстСообщения);
		
	КонецПопытки;
	
	Параметры.ОбработкаЗавершена = ОбработкаЗавершена;
	
КонецПроцедуры

Процедура ВерсииСхемОбменаГИСМ_ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	Возврат;
	
КонецПроцедуры

#КонецОбласти

#Область Прочее

Функция ПроверитьПолучитьОбъект(Ссылка,ВерсияДанных,Очередь) Экспорт
	
	Объект = Ссылка.ПолучитьОбъект();
	Если Объект = Неопределено Тогда
		ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(Ссылка);
		Возврат Неопределено;
	КонецЕсли;
	Если Объект.ВерсияДанных <> ВерсияДанных Тогда
		Возврат Неопределено;
	КонецЕсли;
	Возврат Объект;
	
КонецФункции

#КонецОбласти

#КонецОбласти
