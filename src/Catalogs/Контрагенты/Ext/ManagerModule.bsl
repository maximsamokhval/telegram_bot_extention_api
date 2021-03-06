﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

Функция ДанныеДляПакетаОбмена() Экспорт 
	
	Контейнер = Новый Массив;
	
	Поиск = Новый Запрос(
	"ВЫБРАТЬ
	|	Контрагенты.Ссылка КАК Ссылка,
	|	Контрагенты.Наименование КАК Наименование
	|ИЗ
	|	Справочник.Контрагенты КАК Контрагенты
	|ГДЕ
	|	НЕ Контрагенты.ПометкаУдаления
	|	И НЕ Контрагенты.ЭтоГруппа");
	
	Выборка = Поиск.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		данные = Новый Структура("URL,UUID,name", ПолучитьНавигационнуюСсылку(Выборка.Ссылка), XMLСтрока(Выборка.Ссылка), Выборка.Наименование);
		Контейнер.Добавить(данные);
		
	КонецЦикла;
	
	Возврат Новый ФиксированныйМассив(Контейнер);

	
КонецФункции


#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
	
#КонецЕсли