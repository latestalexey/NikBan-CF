﻿////////////////////////////////////////////////////////////////////////////////
// ЭлектронноеВзаимодействиеКлиентСервер: общий механизм обмена электронными документами.
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

// Заполняет представление настроек регламента ЭДО.
//
// Параметры:
//  СтрокаТаблицы		 - ДанныеФормыЭлементКоллекции - строка таблицы, содержащей данные регламента.
//  ИспользуетсяПрофиль	 - Булево - признак указания в строке профиля настроек.
//
Процедура ЗаполнитьПредставлениеРегламентаЭДОВСтроке(СтрокаТаблицы, ИспользуетсяПрофиль = Ложь) Экспорт 

	Если ИспользуетсяПрофиль Тогда
		Профиль = ""+СтрокаТаблицы.ПрофильНастроекЭДО;
	Иначе
		Профиль = "";
	КонецЕсли;
	
	ИспользоватьЭП = ЭлектронноеВзаимодействиеСлужебныйВызовСервера.ЗначениеФункциональнойОпции("ИспользоватьЭлектронныеПодписиЭД");
	
	Если СтрокаТаблицы.ИспользоватьЭП И ИспользоватьЭП Тогда
		Подпись = НСтр("ru = 'Подпись'");
		
		Маршрут = "";
		Если ЗначениеЗаполнено(СтрокаТаблицы.МаршрутПодписания) Тогда
			Маршрут = " " + СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = '(маршрут: %1)'"), СтрокаТаблицы.МаршрутПодписания);
		КонецЕсли;
	Иначе
		Подпись = НСтр("ru = 'Без подписи'");
		Маршрут = "";
	КонецЕсли;
	
	Если Не ИспользуетсяПрофиль Тогда
		ИнформацияОПодписи = НРег(ИнформацияОПодписи);
	КонецЕсли;
	
	ОтветнаяПодпись = "";
	Если СтрокаТаблицы.ТребуетсяОтветнаяПодпись И ИспользоватьЭП Тогда
		ОтветнаяПодпись = НСтр("ru = 'ответная подпись'");
	КонецЕсли;
	
	ИзвещениеОПолучении = "";
	Если СтрокаТаблицы.ТребуетсяИзвещениеОПолучении Тогда
		ИзвещениеОПолучении = НСтр("ru = 'извещение о получении'");
	КонецЕсли;
	
	ДополнительныеНастройки = "";
	ДополнительныеНастройки = ДополнительныеНастройки
		+ Профиль
		+ ?(Не Профиль = "", ", ", "")
		+ Подпись
		+ Маршрут
		+ ?(Не ИзвещениеОПолучении = "",","+ " ", "")
		+ ИзвещениеОПолучении
		+ ?(Не ОтветнаяПодпись = "",","+ " ", "")
		+ ОтветнаяПодпись;
		
	СтрокаТаблицы.ДополнительныеНастройки = ДополнительныеНастройки;

КонецПроцедуры

// Только для внутреннего использования
Функция ЭтоПрямойОбмен(СпособОбменаЭД) Экспорт
	
	Результат = Ложь;
	Если СпособОбменаЭД = ПредопределенноеЗначение("Перечисление.СпособыОбменаЭД.ЧерезКаталог")
		Или СпособОбменаЭД = ПредопределенноеЗначение("Перечисление.СпособыОбменаЭД.ЧерезЭлектроннуюПочту")
		Или СпособОбменаЭД = ПредопределенноеЗначение("Перечисление.СпособыОбменаЭД.ЧерезFTP") Тогда
		
		Результат = Истина;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция НастройкиРегламентаЭДО(ВидЭД, ВерсияФормата, СпособОбменаЭДО) Экспорт
	
	Настройки = Новый Структура;
	Настройки.Вставить("РедактироватьПодпись", Ложь);
	Настройки.Вставить("РедактироватьИзвещение", Истина);
	Настройки.Вставить("РедактироватьОтветнуюПодпись", Ложь);
	
	Если ВидЭД = ПредопределенноеЗначение("Перечисление.ВидыЭД.АктИсполнитель")
		И (ВРег(ВерсияФормата) = ВРег("ФНС 5.01 (С 2016Г.)")
			Или ВРег(ВерсияФормата) = ВРег("ФНС 5.01 (УПД:Первичный документ)"))Тогда
		
		Настройки.РедактироватьОтветнуюПодпись = Истина;
		
	ИначеЕсли ВидЭД = ПредопределенноеЗначение("Перечисление.ВидыЭД.СчетФактура")
		И ВРег(ВерсияФормата) = ВРег("ФНС 5.01 (УПД:Счет-фактура и первичный документ)") Тогда
		
		Настройки.РедактироватьОтветнуюПодпись = Истина;
		
	ИначеЕсли ВидЭД = ПредопределенноеЗначение("Перечисление.ВидыЭД.ПроизвольныйЭД") Тогда
		Настройки.РедактироватьОтветнуюПодпись = Истина;
		
	КонецЕсли;
	
	Если ЭтоПрямойОбмен(СпособОбменаЭДО) Тогда
		Если ВидЭД = ПредопределенноеЗначение("Перечисление.ВидыЭД.ПроизвольныйЭД") Тогда
			Настройки.РедактироватьПодпись = Ложь;
		Иначе
			Настройки.РедактироватьПодпись = Истина;
			Настройки.РедактироватьОтветнуюПодпись = Истина;
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Настройки;
	
КонецФункции

Функция ТипыОтветныхТитулов() Экспорт

	Результат = Новый Массив;
	Результат.Добавить(ПредопределенноеЗначение("Перечисление.ТипыЭлементовВерсииЭД.ИнформацияПокупателяУПД"));
	Результат.Добавить(ПредопределенноеЗначение("Перечисление.ТипыЭлементовВерсииЭД.ИнформацияПокупателяУКД"));
	Результат.Добавить(ПредопределенноеЗначение("Перечисление.ТипыЭлементовВерсииЭД.ТОРГ12Покупатель"));
	Результат.Добавить(ПредопределенноеЗначение("Перечисление.ТипыЭлементовВерсииЭД.АктЗаказчик"));
	Результат.Добавить(ПредопределенноеЗначение("Перечисление.ТипыЭлементовВерсииЭД.СоглашениеОбИзмененииСтоимостиПолучатель"));
	
	Возврат Результат;

КонецФункции

#КонецОбласти