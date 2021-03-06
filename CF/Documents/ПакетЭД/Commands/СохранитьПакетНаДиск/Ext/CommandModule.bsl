﻿
#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ДанныеФайла = ПолучитьДанныеПрисоединенногоФайлаПакетаНаСервере(ПараметрКоманды, ПараметрыВыполненияКоманды.Источник.УникальныйИдентификатор);
	
	Если ДанныеФайла <> Неопределено Тогда
		ПолучитьФайл(ДанныеФайла.СсылкаНаДвоичныеДанныеФайла, ДанныеФайла.ИмяФайла);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ПолучитьДанныеПрисоединенногоФайлаПакетаНаСервере(Знач ПакетЭД, Знач УникальныйИдентификатор)
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ПакетЭДПрисоединенныеФайлы.Ссылка
	|ИЗ
	|	Справочник.ПакетЭДПрисоединенныеФайлы КАК ПакетЭДПрисоединенныеФайлы
	|ГДЕ
	|	ПакетЭДПрисоединенныеФайлы.ВладелецФайла = &ВладелецФайла";
	
	Запрос.УстановитьПараметр("ВладелецФайла", ПакетЭД);
	
	РезультатЗапроса = Запрос.Выполнить().Выбрать();
	РезультатЗапроса.Следующий();
	
	Если Не ЗначениеЗаполнено(РезультатЗапроса.Ссылка) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			НСтр("ru='Не обнаружен файл пакета электронного документа.'"));
		Возврат Неопределено;
	КонецЕсли;
	
	ДанныеФайла = РаботаСФайлами.ДанныеФайла(РезультатЗапроса.Ссылка,
		УникальныйИдентификатор);
	
	Возврат ДанныеФайла;
	
КонецФункции

#КонецОбласти
