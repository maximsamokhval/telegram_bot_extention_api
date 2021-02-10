﻿////////////////////////////////////////////////////////////////////////////////
// <Заголовок модуля: краткое описание и условия применения модуля.>
//
////////////////////////////////////////////////////////////////////////////////
#Область ПрограммныйИнтерфейс

Функция ПолучитьИнформациюGET(Запрос) Экспорт
	
	Идентификатор = Запрос["ПараметрыURL"].Получить("ID");
	Спецификация = CloudEvents.JSONEventSpec();
	Спецификация.source = ПолучитьНавигационнуюСсылкуИнформационнойБазы();
	
	// todo: переопределить в отдельный модуль с постфиксом _ПЕРЕОПРЕДЕЛЯЕМЫЙ
	Если Идентификатор = "СтатьиДвиженияДенежныхСредств" Тогда
		
		Спецификация.data = Новый Структура("list", СписокСтатейДДС());
		Спецификация.type = "v83.reference.СтатьиДвиженияДенежныхСредств";
		Спецификация.data.Вставить("count", Спецификация.data.list.Количество());
		
	ИначеЕсли Идентификатор = "Контрагенты" Тогда
		
		Спецификация.data = Новый Структура("list", СписокКонтрагентов());
		Спецификация.type = "v83.reference.Контрагенты";
		Спецификация.data.Вставить("count", Спецификация.data.list.Количество());
		
	Иначе
		
		Ответ = Новый HTTPСервисОтвет(400);
		CloudEvents.ОбогатитьЗаголовки(Ответ.Заголовки);
		
		Ответ.УстановитьТелоИзСтроки(ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		
		Возврат Ответ;
		
		
	КонецЕсли;
	
	
	ЗаписьJSON = Новый ЗаписьJSON;
	ПараметрыЗаписиJSON = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Авто, Символы.Таб);
	
	ЗаписьJSON.УстановитьСтроку(ПараметрыЗаписиJSON);
	
	Попытка
		ЗаписатьJSON(ЗаписьJSON, Спецификация);
	Исключение
		
		ЗаписьЖурналаРегистрации("Marshalling", УровеньЖурналаРегистрации.Ошибка, , , ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		Ответ = Новый HTTPСервисОтвет(501);
		CloudEvents.ОбогатитьЗаголовки(Ответ.Заголовки);
		
		Ответ.УстановитьТелоИзСтроки(ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		
		Возврат Ответ;
		
	КонецПопытки;
	
	Ответ = Новый HTTPСервисОтвет(200);
	CloudEvents.ОбогатитьЗаголовки(Ответ.Заголовки);
	Ответ.УстановитьТелоИзСтроки(ЗаписьJSON.Закрыть());
	
	Возврат Ответ;
	
КонецФункции

Функция GetReferenceTypes() Экспорт
	
	ОписаниеМетаданных = Новый Структура;
	ОписаниеМетаданных.Вставить("ReferenceTypes", _Описание.ПодключенныеСправочники());
	
	Спецификация = CloudEvents.JSONEventSpec();
	Спецификация.type = "v83.reference.types";
	Спецификация.data = ОписаниеМетаданных;
	
	Ответ = Новый HTTPСервисОтвет(200);
	Ответ.УстановитьТелоИзСтроки(Marshall(Спецификация));
	CloudEvents.ОбогатитьЗаголовки(Ответ.Заголовки);
	
	Возврат Ответ;
	
КонецФункции

Функция GetDocumentsTypes() Экспорт
	
	ОписаниеМетаданных = Новый Структура;
	ОписаниеМетаданных.Вставить("DocumentsTypes", _Описание.ПодключенныеДокументы());
	
	Спецификация = CloudEvents.JSONEventSpec();
	Спецификация.type = "v83.documents.types";
	Спецификация.data = ОписаниеМетаданных;
	
	Ответ = Новый HTTPСервисОтвет(200);
	Ответ.УстановитьТелоИзСтроки(Marshall(Спецификация));
	CloudEvents.ОбогатитьЗаголовки(Ответ.Заголовки);
	
	Возврат Ответ;
	
КонецФункции

Функция GetMetadata() Экспорт
	
	ОписаниеМетаданных = Новый Соответствие;
	
	ОписаниеМетаданных.Вставить("v83.http.methods", _Описание.РеализованныеМетоды());
	ОписаниеМетаданных.Вставить("v83.reference.types", _Описание.ПодключенныеСправочники());
	ОписаниеМетаданных.Вставить("v83.documents.types", _Описание.ПодключенныеДокументы());
	
	ИнфоОПоставке = Новый Соответствие;
	ИнфоОПоставке.Вставить("v83.metaname", Метаданные.Синоним);
	ИнфоОПоставке.Вставить("v83.meta.version", Метаданные.Версия);
	ИнфоОПоставке.Вставить("vendor", "https://t.me/maksym_samokhval");
	ИнфоОПоставке.Вставить("info", "https://github.com/maximsamokhval/telegram_bot_extention_api");
	ОписаниеМетаданных.Вставить("info", ИнфоОПоставке);
	
	Спецификация = CloudEvents.JSONEventSpec();
	Спецификация.type = "v83.metadata.types";
	Спецификация.data = ОписаниеМетаданных;
	
	Ответ = Новый HTTPСервисОтвет(200);
	Ответ.УстановитьТелоИзСтроки(Marshall(Спецификация));
	CloudEvents.ОбогатитьЗаголовки(Ответ.Заголовки);
	
	Возврат Ответ;
	
КонецФункции


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция Marshall(Спецификация)
	
	ЗаписьJSON = Новый ЗаписьJSON;
	ПараметрыЗаписиJSON = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Авто, Символы.Таб);
	ЗаписьJSON.УстановитьСтроку(ПараметрыЗаписиJSON);
	ЗаписатьJSON(ЗаписьJSON, Спецификация);
	Возврат ЗаписьJSON.Закрыть();
	
КонецФункции


Функция СписокКонтрагентов()
	
	Возврат Справочники.Контрагенты.ДанныеДляПакетаОбмена();
	
КонецФункции

Функция СписокСтатейДДС()
	Возврат Справочники.СтатьиДвиженияДенежныхСредств.ДанныеДляПакетаОбмена();
КонецФункции
#КонецОбласти