﻿
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции
Функция НадоЗаполнять()

	Если Не Константы.ИспользоватьРазделениеПоОбластямДанных.Получить() Тогда
		Возврат ПолучитьФункциональнуюОпцию("ВестиУчетПодконтрольныхТоваровВЕТИС")
			И Не ВерсияПеречняСодержитГруппу35();
	Иначе
		Возврат Не ВерсияПеречняСодержитГруппу35();
	КонецЕсли;

КонецФункции // НадоЗаполнять())

Функция ВерсияПеречняСодержитГруппу35()

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	ВидыПродукцииПоГруппамПриказаВЕТИС.ВидПродукцииИдентификатор КАК ВидПродукцииИдентификатор
	|ИЗ
	|	РегистрСведений.ВидыПродукцииПоГруппамВЕТИС КАК ВидыПродукцииПоГруппамПриказаВЕТИС
	|ГДЕ
	|	ВидыПродукцииПоГруппамПриказаВЕТИС.ГруппаПриказа = Значение(Перечисление.ГруппыПродукцииУполномоченныхЛиц.Группа35Строка1)";
	
	Возврат Не Запрос.Выполнить().Пустой()
	
КонецФункции // ВерсияПеречняСодержитГруппу35()

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры = Неопределено) Экспорт
	
	Если Не НадоЗаполнять() Тогда
		Возврат;
	КонецЕсли;
	
	НачатьТранзакцию();
	
	Попытка
		БлокировкаДанных = Новый БлокировкаДанных;
		ЭлементБлокировки = БлокировкаДанных.Добавить("РегистрСведений.ВидыПродукцииПоГруппамВЕТИС");
		ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
		БлокировкаДанных.Заблокировать();
		
		НаборЗаписей = РегистрыСведений.ВидыПродукцииПоГруппамВЕТИС.СоздатьНаборЗаписей();
		НаборЗаписей.Записать();
		
		ДопустимыеЦелиВЕТИС.ЗаполнитьДанныеВРегистреВидыПродукцииПоГруппамПриказаВЕТИС();
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		
		ТекстСообщения = СтрШаблон(
			НСтр("ru = 'Не удалось обработать регистр ВидыПродукцииПоГруппамВЕТИС по причине: %1'",
				ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
			ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(),
			УровеньЖурналаРегистрации.Предупреждение,
			Метаданные.РегистрыСведений.ВидыПродукцииПоГруппамВЕТИС,,
			ТекстСообщения);
		
	КонецПопытки;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли