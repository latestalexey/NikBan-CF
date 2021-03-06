﻿
#Область ПрограммныйИнтерфейс

// Заполняет список выбора для колонки СтавкаНДС.
//
// Параметры:
//  Элементы 	- ЭлементыФормы - Все элементы переданной формы.
//  Дата 		- Дата - дата на которую необходимо получить актуальную ставку НДС.
//
Процедура ЗаполнитьСписокВыбораСтавокНДС(Элементы, Дата) Экспорт 
	
	Ставка20_18 = СтавкаНДСПоУмолчанию(Дата);
	
	Элементы.ТоварыСтавкаНДС.СписокВыбора.Очистить();
	
	МассивСтавокНДС = Новый Массив;
	МассивСтавокНДС.Добавить(Перечисления.СтавкиНДС.БезНДС);
	МассивСтавокНДС.Добавить(Перечисления.СтавкиНДС.НДС10);
	МассивСтавокНДС.Добавить(Ставка20_18);
	
	Элементы.ТоварыСтавкаНДС.СписокВыбора.ЗагрузитьЗначения(МассивСтавокНДС);
	
КонецПроцедуры

// Заменяет переданную ставку НДС на актуальную на указанную дату.
//
// Параметры:
//  СтавкаНДС 	- ПеречислениеСсылка.СтавкиНДС - значение ставки НДС, которое необходимо скорректировать
//  Дата 		- Дата - дата на которую необходимо получить актуальную ставку НДС.
//
// Возвращаемое значение:
//  ПеречислениеСсылка.СтавкиНДС - значение ставки НДС.
//
Функция СкорректироватьСтавкуНДС(СтавкаНДС, Дата) Экспорт
	
	Если СтавкаНДС = Перечисления.СтавкиНДС.НДС18 Или СтавкаНДС = Перечисления.СтавкиНДС.НДС18_118
		Или СтавкаНДС = Перечисления.СтавкиНДС.НДС20 Или СтавкаНДС = Перечисления.СтавкиНДС.НДС20_120 Тогда
		
		СтавкаНДС = СтавкаНДСПоУмолчанию(Дата);
			
	КонецЕсли;
	
	Возврат СтавкаНДС;
	
КонецФункции

// Заменяет ставки НДС в табличной части документа на актуальную на дату документа,
// а также пересчитывает соответствующие суммы НДС.
//
// Параметры:
//  Документ - ДокуменОбъект - объект документа, в табличной части которого необходимо заменить ставки НДС
//  ТабличнаяЧасть - ДокументТабличнаяЧасть - табличная часть документа
//  СтруктураПересчетаСуммы - Структура - см. ОбработкаТабличнойЧастиКлиентСервер.ПараметрыПересчетаСуммыНДСВСтрокеТЧ().
//
Процедура СкорректироватьНДСВТЧДокумента(Документ, ТабличнаяЧасть) Экспорт
	
	Если Не ЗначениеЗаполнено(ТабличнаяЧасть) Тогда
		Возврат;
	КонецЕсли;
	
	ДатаАктуальности = ?(ЗначениеЗаполнено(Документ.Дата), Документ.Дата, ТекущаяДатаСеанса());
	
	Для каждого СтрокаТЧ Из ТабличнаяЧасть Цикл
		
		СтавкаНДС = СкорректироватьСтавкуНДС(СтрокаТЧ.СтавкаНДС, ДатаАктуальности);
		СтрокаТЧ.СуммаНДС = ОбработкаТабличнойЧастиТоварыСервер.РассчитатьСуммуНДС(СтрокаТЧ.Сумма, СтавкаНДС, Документ.ЦенаВключаетНДС);
			
	КонецЦикла;
	
КонецПроцедуры

// Возвращает законодательно установленную дату переходного периода при учете НДС
Функция ДатаПереходногоПериода() Экспорт
	
	Возврат Дата("20190101");
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает значение ставки НДС по умолчанию.
//
// Параметры:
//  Дата - Дата - дата на которую необходимо получить ставку НДС по умолчанию,
//               если дата пустая, то будет получена ставка НДС на текущую дату
//
// Возвращаемое значение:
//  ПеречислениеСсылка.СтавкиНДС - значение ставки НДС.
//
Функция СтавкаНДСПоУмолчанию(Дата = Неопределено) Экспорт
	
	ДатаПолучения = ?(ЗначениеЗаполнено(Дата), Дата, ТекущаяДатаСеанса());
	
	Если ДатаПолучения >= ДатаПереходногоПериода() Тогда
		Возврат Перечисления.СтавкиНДС.НДС20;
	Иначе
		Возврат Перечисления.СтавкиНДС.НДС18;
	КонецЕсли;
	
КонецФункции


#КонецОбласти