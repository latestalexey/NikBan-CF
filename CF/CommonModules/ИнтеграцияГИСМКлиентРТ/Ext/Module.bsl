﻿////////////////////////////////////////////////////////////////////////////////
// <Заголовок модуля: краткое описание и условия применения модуля.>
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс


// См. процедуру ИнтеграцияГИСМКлиентПереопределяемый.ЗаявкаНаВыпускКиЗЗаказанныеКиЗПриИзменении
//
Процедура ЗаявкаНаВыпускКиЗЗаказанныеКиЗПриИзменении(Форма, КэшированныеЗначения, Элемент) Экспорт
	
	ТекущиеДанные = Форма.Элементы.ЗаказанныеКиЗ.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СтруктураДействий = Новый Структура;
	СтруктураДействий.Вставить("ПроверитьХарактеристикуПоВладельцу", ТекущиеДанные.Характеристика);
	СтруктураДействий.Вставить("ЗаполнитьПризнакТипНоменклатуры", Новый Структура("Номенклатура", "ТипНоменклатуры"));
	СтруктураДействий.Вставить("ЗаполнитьТипНоменклатуры");
	
	СтруктураДействий.Вставить("НоменклатураПриИзмененииПереопределяемый",
	                           Новый Структура("ИмяФормы, ИмяТабличнойЧасти", Форма.ИмяФормы, "ЗаказанныеКиЗ"));
	
	ОбработкаТабличнойЧастиТоварыКлиент.ПриИзмененииРеквизитовВТЧКлиент(Форма.Объект.ЗаказанныеКиЗ, ТекущиеДанные, СтруктураДействий, КэшированныеЗначения);
	
КонецПроцедуры

// См. функцию ИнтеграцияГИСМКлиентПереопределяемый.ИсточникВыбораЭтоФормаПодбора
//
Функция ИсточникВыбораЭтоФормаПодбора(ИсточникВыбора) Экспорт
	
	Если ИсточникВыбора.ИмяФормы = "Обработка.ПодборТоваров.Форма.Форма" Тогда
		
		Возврат Истина;
		
	КонецЕсли;
	
	Возврат Ложь;
	
КонецФункции

// См. процедуру ИнтеграцияГИСМКлиентПереопределяемый.ТоварыУведомлениеОбИмпортеНоменклатураКиЗПриИзменении
//
Процедура ОткрытьПодборЗаказываемыхКиЗ(Форма) Экспорт
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Документ",                          Форма.Объект.Ссылка);
	ПараметрыФормы.Вставить("Контрагент",                        Форма.Объект.Контрагент);
	ПараметрыФормы.Вставить("ОсобенностьУчета",                  ПредопределенноеЗначение("Перечисление.ОсобенностиУчетаНоменклатуры.КиЗГИСМ"));
	ПараметрыФормы.Вставить("РежимПодбораБезСуммовыхПараметров", Истина);
	ПараметрыФормы.Вставить("СкрыватьРучныеСкидки",              Истина);
	ПараметрыФормы.Вставить("Дата",                              Форма.Объект.Дата);
	
	ОткрытьФорму("Обработка.ПодборТоваров.Форма", ПараметрыФормы, Форма, Форма.УникальныйИдентификатор);
	
КонецПроцедуры

// См. процедуру ИнтеграцияГИСМКлиентПереопределяемый.ОткрытьФормуСпискаДокументов
//
Процедура ОткрытьФормуСпискаДокументов(СписокДокументов, Заголовок) Экспорт

	ПараметрыФормы = Новый Структура;
			ПараметрыФормы.Вставить("СписокДокументов", СписокДокументов);
			ПараметрыФормы.Вставить("Заголовок", НСтр(Заголовок));
			
			ОткрытьФорму("ОбщаяФорма.ПросмотрСпискаДокументов",
			                ПараметрыФормы,
			                ЭтотОбъект);

КонецПроцедуры

// См. процедуру ИнтеграцияГИСМКлиентПереопределяемый.ПараметрыОткрытияСпискаВозвратыТоваровОтРозничныхКлиентов
//
Функция ПараметрыОткрытияСпискаВозвратыТоваровОтРозничныхКлиентов() Экспорт
	
	СтруктураВозврата = Новый Структура();
	СтруктураВозврата.Вставить("ИмяФормы", "Документ.ВозвратТоваровОтПокупателя.Форма.ФормаСписка");
	СтруктураВозврата.Вставить("ДальнейшееДействиеГИСМ", ПредопределенноеЗначение("Перечисление.ДальнейшиеДействияПоВзаимодействиюГИСМ.ПередайтеДанные"));
	СтруктураВозврата.Вставить("ОткрытьРаспоряжения", Ложь);
	СтруктураВозврата.Вставить("ИмяПоляОтветственный", "Ответственный");
	СтруктураВозврата.Вставить("ИмяПоляОрганизация", "Организация");
	
	Возврат СтруктураВозврата;
	
КонецФункции

// См. процедуру ИнтеграцияГИСМКлиентПереопределяемый.ПараметрыОткрытияСпискаОтчетыОРозничныхПродажах
//
Функция ПараметрыОткрытияСпискаОтчетыОРозничныхПродажах() Экспорт
	
	СтруктураВозврата = Новый Структура();
	СтруктураВозврата.Вставить("ИмяФормы", "Документ.ОтчетОРозничныхПродажах.Форма.ФормаСписка");
	СтруктураВозврата.Вставить("ДальнейшееДействиеГИСМ", ПредопределенноеЗначение("Перечисление.ДальнейшиеДействияПоВзаимодействиюГИСМ.ПередайтеДанные"));
	СтруктураВозврата.Вставить("ОткрытьРаспоряжения", Ложь);
	СтруктураВозврата.Вставить("ИмяПоляОтветственный", "Ответственный");
	СтруктураВозврата.Вставить("ИмяПоляОрганизация", "Организация");
	
	Возврат СтруктураВозврата;
	
КонецФункции

// См. процедуру ИнтеграцияГИСМКлиентПереопределяемый.ТоварыУведомлениеОбИмпортеНоменклатураКиЗПриИзменении
//
Процедура ТоварыУведомлениеОбИмпортеНоменклатураКиЗПриИзменении(ТекущаяСтрока, КэшированныеЗначения) Экспорт
	
	СтруктураДействий = Новый Структура;
	
	СтруктураДействий.Вставить("ПроверитьХарактеристикуПоВладельцу", ТекущаяСтрока.ХарактеристикаКиЗ);
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("Номенклатура", "НоменклатураКиЗ");
	СтруктураПараметров.Вставить("ХарактеристикиИспользуются", "ХарактеристикиКиЗИспользуются");
	
	СтруктураДействий.Вставить("ЗаполнитьПризнакХарактеристикиИспользуются", СтруктураПараметров);
	ОбработкаТабличнойЧастиТоварыКлиент.ОбработатьСтрокуТЧКлиент(ТекущаяСтрока, СтруктураДействий, КэшированныеЗначения);

КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПреобразоватьДанныеСоСканераВМассив(Параметр) Экспорт
	
	Данные = Новый Массив;
	Данные.Добавить(ПреобразоватьДанныеСоСканераВСтруктуру(Параметр));
	
	Возврат Данные;
	
КонецФункции

Функция ПреобразоватьДанныеСоСканераВСтруктуру(Параметр) Экспорт
	
	Если Параметр[1] = Неопределено Тогда
		Данные = Новый Структура("Штрихкод, Количество", Параметр[0], 1);    // Достаем штрихкод из основных данных
	Иначе
		Данные = Новый Структура("Штрихкод, Количество", Параметр[1][1], 1); // Достаем штрихкод из дополнительных данных
	КонецЕсли;
	
	Возврат Данные;
	
КонецФункции

#КонецОбласти

#Область РаботаСПрикладнымиДокументами

// См. процедуру ИнтеграцияГИСМКлиентПереопределяемый.ТекстУведомленияОбОтгрузкеГИСМОбработкаНавигационнойСсылки
//
Процедура ТекстУведомленияОбОтгрузкеГИСМОбработкаНавигационнойСсылки(Форма, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка) Экспорт
	
	СтандартнаяОбработка = Ложь;
	
	Если НавигационнаяСсылкаФорматированнойСтроки = "ОткрытьПротоколОбмена" Тогда
		
		ИнтеграцияГИСМКлиент.ОткрытьПротоколОбмена(Форма.Объект.Ссылка, Форма);
		
	ИначеЕсли НавигационнаяСсылкаФорматированнойСтроки = "СоздатьУведомлениеГИСМ" Тогда
		
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("Основание", Форма.Объект.Ссылка);
		ОткрытьФорму("Документ.УведомлениеОбОтгрузкеМаркированныхТоваровГИСМ.Форма.ФормаДокумента", ПараметрыФормы, Форма);
		
	КонецЕсли;

КонецПроцедуры

// См. процедуру ИнтеграцияГИСМКлиентПереопределяемый.ТекстУведомленияОСписанииКиЗГИСМОбработкаНавигационнойСсылки
//
Процедура ТекстУведомленияОСписанииКиЗГИСМОбработкаНавигационнойСсылки(Форма, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка) Экспорт
	
	СтандартнаяОбработка = Ложь;
	
	Если НавигационнаяСсылкаФорматированнойСтроки = "ОткрытьПротоколОбмена" Тогда
		
		ИнтеграцияГИСМКлиент.ОткрытьПротоколОбмена(Форма.Объект.Ссылка, Форма);
		
	ИначеЕсли НавигационнаяСсылкаФорматированнойСтроки = "СоздатьУведомлениеГИСМ" Тогда
		
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("Основание", Форма.Объект.Ссылка);
		ОткрытьФорму("Документ.УведомлениеОСписанииКиЗГИСМ.Форма.ФормаДокумента", ПараметрыФормы, Форма);
		
	КонецЕсли;

КонецПроцедуры

// См. процедуру ИнтеграцияГИСМКлиентПереопределяемый.ТекстЗаявкаНаВыпускКиЗОбработкаНавигационнойСсылки
//
Процедура ТекстЗаявкаНаВыпускКиЗОбработкаНавигационнойСсылки(Форма, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка) Экспорт
	
	СтандартнаяОбработка = Ложь;
	Если НавигационнаяСсылкаФорматированнойСтроки = "ОткрытьПротоколОбмена" Тогда
		
		ИнтеграцияГИСМКлиент.ОткрытьПротоколОбмена(Форма.Объект.Ссылка, Форма);
		
	ИначеЕсли НавигационнаяСсылкаФорматированнойСтроки = "СоздатьЗаявкуНаВыпускКиЗ" Тогда
		
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("Основание", Форма.Объект.Ссылка);
		ОткрытьФорму("Документ.ЗаявкаНаВыпускКиЗГИСМ.Форма.ФормаДокумента", ПараметрыФормы, Форма);
		
	КонецЕсли;
	
КонецПроцедуры

// См. процедуру ИнтеграцияГИСМКлиентПереопределяемый.ТекстУведомленияОбИмпортеВвозеИзЕАЭСОбработкаНавигационнойСсылки
//
Процедура ТекстУведомленияОбИмпортеВвозеИзЕАЭСОбработкаНавигационнойСсылки(Форма, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка) Экспорт
	
	СтандартнаяОбработка = Ложь;
	
	Если НавигационнаяСсылкаФорматированнойСтроки = "ОткрытьПротоколОбмена" Тогда
		
		ИнтеграцияГИСМКлиент.ОткрытьПротоколОбмена(Форма.Объект.Ссылка, Форма);
		
	ИначеЕсли НавигационнаяСсылкаФорматированнойСтроки = "СоздатьУведомлениеГИСМ" Тогда
		
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("Основание", Форма.Объект.Ссылка);
		
		Если Форма.Объект.ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ЗакупкаПоИмпорту") Тогда
			ОткрытьФорму("Документ.УведомлениеОбИмпортеМаркированныхТоваровГИСМ.Форма.ФормаДокумента", ПараметрыФормы, Форма);
		ИначеЕсли Форма.Объект.ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ЗакупкаВСтранахЕАЭС") Тогда
			ОткрытьФорму("Документ.УведомлениеОВвозеМаркированныхТоваровИзЕАЭСГИСМ.Форма.ФормаДокумента", ПараметрыФормы, Форма);
		КонецЕсли;
		
	КонецЕсли;

КонецПроцедуры

#КонецОбласти
