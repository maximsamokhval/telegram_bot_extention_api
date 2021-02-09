﻿////////////////////////////////////////////////////////////////////////////////
// <Заголовок модуля: краткое описание и условия применения модуля.>
//  
////////////////////////////////////////////////////////////////////////////////
#Область ПрограммныйИнтерфейс

// Шаблон JsonEvent
//  https://github.com/cloudevents/spec/blob/v1.0.1/json-format.md
// 
// Возвращаемое значение:
//   - 
//
Функция JsonEventSpec() Экспорт
	
	Спецификация = Новый Структура;
	Спецификация.Вставить("specversion", "1.0");
	Спецификация.Вставить("type", "");
	Спецификация.Вставить("source", СтрокаСоединенияИнформационнойБазы());
	Спецификация.Вставить("id", XMLСтрока(новый УникальныйИдентификатор));
	Спецификация.Вставить("time", ТекущаяДатаСеанса());
	Спецификация.Вставить("datacontenttype", "application/json");
	Спецификация.Вставить("data", Новый Структура);
	
	Возврат Спецификация;
	
КонецФункции

Процедура ОбогатитьЗаголовки(HttpЗаголовки, ce_type = "") Экспорт 
	
	HttpЗаголовки.Вставить("Content-Type", "application/cloudevents+json; charset=UTF-8");
	HttpЗаголовки.Вставить("ce-specversion", "1.0");
	HttpЗаголовки.Вставить("ce-type", ce_type);
	HttpЗаголовки.Вставить("ce-time", ТекущаяДатаСеанса());
	HttpЗаголовки.Вставить("ce-id", XMLСтрока(Новый УникальныйИдентификатор));
	HttpЗаголовки.Вставить("ce-source", ПолучитьНавигационнуюСсылкуИнформационнойБазы()); 
	
КонецПроцедуры


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
