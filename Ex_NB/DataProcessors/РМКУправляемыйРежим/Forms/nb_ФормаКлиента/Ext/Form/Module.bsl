﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("ВладелецДисконтнойКарты") Тогда
		ВладелецДисконтнойКарты = Параметры.ВладелецДисконтнойКарты;
	КонецЕсли;
	
	Если Параметры.Свойство("ДисконтнаяКарта") Тогда
		ДисконтнаяКарта = Параметры.ДисконтнаяКарта;
	КонецЕсли;
	
	nb_КоличествоБаловДружба = nb_ПрограммаЛояльностиДружбаСервер.ПолучитьКоличествоБалловДисконтнойКарты(ДисконтнаяКарта);

КонецПроцедуры


&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
КонецПроцедуры

