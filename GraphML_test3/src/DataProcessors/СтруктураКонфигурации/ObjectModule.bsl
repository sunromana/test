//перем ДеревоПодсистемИОбъектов экспорт;

Процедура ЗадатьТипыДанныхXML(XML)	экспорт
	
	key1 = XML.createElement("key");
	key1.setAttribute("for","node");    
	key1.setAttribute("id","d0");    
	key1.setAttribute("yfiles.type","nodegraphics");    
	XML.ЭлементДокумента.ДобавитьДочерний(key1);

	key1 = XML.createElement("key");
	key1.setAttribute("for","node");
	key1.setAttribute("id","d1");
	key1.setAttribute("attr.name","description");
	key1.setAttribute("attr.type","string");
	XML.ЭлементДокумента.ДобавитьДочерний(key1);
	
	key1 = XML.createElement("key");
	key1.setAttribute("for","edge");    
	key1.setAttribute("id","d2");    
	key1.setAttribute("yfiles.type","edgegraphics");    
	XML.ЭлементДокумента.ДобавитьДочерний(key1);

	key1 = XML.createElement("key");
	key1.setAttribute("for","edge");
	key1.setAttribute("id","d3");
	key1.setAttribute("attr.name","description");    
	key1.setAttribute("attr.type","string");        	
	XML.ЭлементДокумента.ДобавитьДочерний(key1);

	key1 = XML.createElement("key");
	key1.setAttribute("for","graphml");    
	key1.setAttribute("id","d4");    
	key1.setAttribute("yfiles.type","resources");    	
	XML.ЭлементДокумента.ДобавитьДочерний(key1);
	
	key1 = XML.createElement("key");
	key1.setAttribute("for","node");
	key1.setAttribute("id","d5");
	key1.setAttribute("attr.name","Подсистема");
	key1.setAttribute("attr.type","string");	
	XML.ЭлементДокумента.ДобавитьДочерний(key1);
	
	
	
	
	key1 = XML.createElement("key");
	key1.setAttribute("for","graphml");
	key1.setAttribute("id","d7");
	key1.setAttribute("yfiles.type","resources");	
	XML.ЭлементДокумента.ДобавитьДочерний(key1);
	
	key1 = XML.createElement("key");
	key1.setAttribute("for","edge");
	key1.setAttribute("id","d8");
	key1.setAttribute("attr.name","url");
	key1.setAttribute("attr.type","string");	
	XML.ЭлементДокумента.ДобавитьДочерний(key1);
	
	key1 = XML.createElement("key");
	key1.setAttribute("for","edge");
	key1.setAttribute("id","d9");
	key1.setAttribute("attr.name","description");
	key1.setAttribute("attr.type","string");	
	XML.ЭлементДокумента.ДобавитьДочерний(key1);
	
	key1 = XML.createElement("key");
	key1.setAttribute("for","edge");
	key1.setAttribute("id","d10");
	key1.setAttribute("yfiles.type","edgegraphics");
	XML.ЭлементДокумента.ДобавитьДочерний(key1);
	
	//<key for="graphml" id="d7" yfiles.type="resources" /> 
	//  <key attr.name="url" attr.type="string" for="edge" id="d8" /> 
	//  <key attr.name="description" attr.type="string" for="edge" id="d9" /> 
	//  <key for="edge" id="d10" yfiles.type="edgegraphics" /> 

	
КонецПроцедуры

Функция ВернутьПрефиксОбъектаМетаданных(ом) экспорт
	
	префикс = "неопределено";
	
	Если Метаданные.Справочники.Содержит(ом) Тогда
		префикс = "спр_";
	ИначеЕсли Метаданные.Документы.Содержит(ом) Тогда
		префикс = "док_";
	ИначеЕсли Метаданные.РегистрыНакопления.Содержит(ом) Тогда
		префикс = "рн_";
	ИначеЕсли Метаданные.РегистрыСведений.Содержит(ом) Тогда
		префикс = "рс_";
	ИначеЕсли Метаданные.ПланыВидовХарактеристик.Содержит(ом) Тогда
		префикс = "пвх_";		
	КонецЕсли;
	
	Возврат префикс;
	
КонецФункции

Функция ПолучитьСоставПодсистем(Подсистемы = "", дзПодсистемы = "") экспорт
	Если дзПодсистемы = "" Тогда
		дзПодсистемы = Новый ДеревоЗначений;
		дзПодсистемы.Колонки.Добавить("Подсистема");
		дзПодсистемы.Колонки.Добавить("ОбъектМетаданных");
	КонецЕсли;
	
	Если Подсистемы = "" Тогда
		Подсистемы = Метаданные.Подсистемы;
	КонецЕсли;
	
	Для каждого ТекПодсистема Из Подсистемы Цикл
		
		стр = дзПодсистемы.Строки.Добавить();
		стр.Подсистема = ТекПодсистема;
		стр.ОбъектМетаданных = "-- подсистема --";
						
		Для каждого ом из ТекПодсистема.Состав Цикл
			стрСостав = стр.Строки.Добавить();
			стрСостав.Подсистема = ТекПодсистема;
			стрСостав.ОбъектМетаданных = ом;
		КонецЦикла;
			
		
		ПолучитьСоставПодсистем(ТекПодсистема.Подсистемы, стр);
	КонецЦикла;
	
	Возврат дзПодсистемы;
КонецФункции



//----- примитивы и соединительные линии -----

Процедура ДобавитьВСхему_Edge(XML, graph, source, target, EdgeLabel="", Атрибуты="") экспорт
	
	элРеквизит = XML.СоздатьЭлемент("edge");
	элРеквизит.УстановитьАтрибут("source", Строка(source));
	элРеквизит.УстановитьАтрибут("target", Строка(target));
	
	элРеквизит1 = XML.СоздатьЭлемент("data");
	элРеквизит1.УстановитьАтрибут("key", "d10");			
	элРеквизит.ДобавитьДочерний(элРеквизит1);

	элРеквизит2 = XML.СоздатьЭлемент("y:PolyLineEdge");
	
	Если Атрибуты = "" Тогда
		label = XML.createElement("y:Arrows");
		label.setAttribute("source", "crows_foot_many");
		label.setAttribute("target", "none");
		элРеквизит2.appendChild(label);
		
		label = XML.createElement("y:EdgeLabel");
		//label.setAttribute("source", "crows_foot_many");
		//label.setAttribute("target", "none");
		label.appendChild(XML.createTextNode(EdgeLabel));
		элРеквизит2.appendChild(label);
	Иначе
		label = XML.createElement("y:Arrows");
		label.setAttribute("source", Атрибуты.Arrows_source);
		label.setAttribute("target", Атрибуты.Arrows_target);
		элРеквизит2.appendChild(label);
		
		label = XML.createElement("y:LineStyle");
		label.setAttribute("LineStyle_color", Атрибуты.LineStyle_color);
		label.setAttribute("LineStyle_type", Атрибуты.LineStyle_type);
		label.setAttribute("LineStyle_width", Атрибуты.LineStyle_width);
		элРеквизит2.appendChild(label);
		
		label = XML.createElement("y:EdgeLabel");
		label.setAttribute("modelName", Атрибуты.EdgeLabel_modelName);
		label.setAttribute("modelPosition", Атрибуты.EdgeLabel_modelPosition);
		label.appendChild(XML.createTextNode(EdgeLabel));
		элРеквизит2.appendChild(label);				
	КонецЕсли;
	
	элРеквизит1.ДобавитьДочерний(элРеквизит2);
	
	graph.ДобавитьДочерний(элРеквизит);
	
КонецПроцедуры

Процедура ДобавитьВСхему_Shape(XML, graph) экспорт  //только заготовка, нерабочая процедура
	
	//Для каждого Справочник из Метаданные.Справочники Цикл
	Для н = 0 по 5 Цикл
		
		элРеквизит = XML.СоздатьЭлемент("node");
		элРеквизит.УстановитьАтрибут("id", "n"+Строка(н));
		graph.ДобавитьДочерний(элРеквизит);
		
			элРеквизит1 = XML.СоздатьЭлемент("data");
			элРеквизит1.УстановитьАтрибут("key", "d0");			
			элРеквизит.ДобавитьДочерний(элРеквизит1);
								
				snode = XML.createElement("y:ShapeNode");
				
					label = XML.createElement("y:Shape");
					label.setAttribute("type", "roundrectangle");					
					snode.appendChild(label);
					
					label = XML.createElement("y:Geometry");
					label.setAttribute("height", "50.0");
					label.setAttribute("width", "100.0");
					label.setAttribute("x", "0.0");
					label.setAttribute("y", "0.0");
					snode.appendChild(label);					

				
					label = XML.createElement("y:NodeLabel");
					label.appendChild(XML.createTextNode("раз,
														|два,
														|три!"));
					snode.appendChild(label);
				
				элРеквизит1.ДобавитьДочерний(snode);
					
	КонецЦикла;

КонецПроцедуры




//----- ERD ----
Процедура ДобавитьВСхему_entityRelationship(XML, graph, таблица1С, ИмяПодсистемы = "") экспорт	 
	
	цветШапки = "";
	Если Метаданные.Справочники.Содержит(таблица1С) Тогда
		префикс = "спр_";
		цветШапки = "#b7c9e3";
	ИначеЕсли Метаданные.Документы.Содержит(таблица1С) Тогда
		префикс = "док_";
		цветШапки = "#ffd760";
	ИначеЕсли Метаданные.РегистрыНакопления.Содержит(таблица1С) Тогда		
		цветШапки = "#ff9999";
		префикс = "рн_";
	ИначеЕсли Метаданные.РегистрыСведений.Содержит(таблица1С) Тогда
		цветШапки = "#ff9999";
		префикс = "рс_";
	ИначеЕсли Метаданные.РегистрыБухгалтерии.Содержит(таблица1С) Тогда
		цветШапки = "#ff9999";
		префикс = "рб_";	
	ИначеЕсли Метаданные.ПланыВидовХарактеристик.Содержит(таблица1С) Тогда
		префикс = "пвх_";
		цветШапки = "#b7c9e3";
	КонецЕсли;
	
	ИмяТаблицы = ?(таблица1С.Синоним <> "", таблица1С.Синоним, таблица1С.Имя);	
	СписокАтрибутов = "";
	
	н = 0;	
	МаксимальнаяДлинаИмениРеквизита = СтрДлина(ИмяТаблицы);
	СписокАтрибутов_HTMLформат = "<html>";
	Для каждого реквизит из таблица1С.Реквизиты Цикл
		
		Если СтрДлина(реквизит.Имя) > МаксимальнаяДлинаИмениРеквизита Тогда
			МаксимальнаяДлинаИмениРеквизита = СтрДлина(реквизит.Имя);
		КонецЕсли;
		
		Если Справочники.ТипВсеСсылки().СодержитТип(Реквизит.Тип.Типы()[0]) 
			или Документы.ТипВсеСсылки().СодержитТип(Реквизит.Тип.Типы()[0]) Тогда			
			реквизитИмя = "(FK)" + реквизит.Имя;
			реквизитИмя_HTMLформат = "<u>" + реквизит.Имя + "</u>";
		Иначе
			реквизитИмя = реквизит.Имя;
			реквизитИмя_HTMLформат = реквизит.Имя;
		КонецЕсли;
		
		
		СписокАтрибутов = СписокАтрибутов + Символы.ПС + реквизитИмя;
		СписокАтрибутов_HTMLформат = СписокАтрибутов_HTMLформат + "<br>" + Символы.ПС + реквизитИмя_HTMLформат;		
	
		н=н+1;		
	КонецЦикла;
	
	элРеквизит = XML.СоздатьЭлемент("node");
	элРеквизит.УстановитьАтрибут("id", префикс + таблица1С.Имя);	
	graph.ДобавитьДочерний(элРеквизит);
	
	элРеквизит1 = XML.СоздатьЭлемент("data");
	элРеквизит1.УстановитьАтрибут("key", "d0");			
	элРеквизит.ДобавитьДочерний(элРеквизит1);
	
	элРеквизит33 = XML.СоздатьЭлемент("data");
	элРеквизит33.УстановитьАтрибут("key", "d5");
	Если СокрЛП(ИмяПодсистемы)<>"" Тогда
		элРеквизит33.ДобавитьДочерний(XML.createTextNode(ИмяПодсистемы));
	КонецЕсли;
	элРеквизит.ДобавитьДочерний(элРеквизит33);

	элРеквизит2 = XML.СоздатьЭлемент("y:GenericNode");
	элРеквизит2.УстановитьАтрибут("configuration", "com.yworks.entityRelationship.big_entity");
	
	label = XML.createElement("y:Geometry");
	label.setAttribute("height", СтрЗаменить(Строка(55 + 14*н),Символы.НПП,""));
	label.setAttribute("width", СтрЗаменить(Строка(100 + 4*МаксимальнаяДлинаИмениРеквизита),Символы.НПП,""));
	элРеквизит2.appendChild(label);
	
	label = XML.createElement("y:Fill");
	label.setAttribute("color", "#E8EEF7");
	label.setAttribute("color2", "#B7C9E3");
	label.setAttribute("transparent", "false");
	элРеквизит2.appendChild(label);
	
	label = XML.createElement("y:NodeLabel");	
	label.УстановитьАтрибут("alignment", "center");
	label.УстановитьАтрибут("autoSizePolicy", "node_width");
	label.УстановитьАтрибут("backgroundColor", цветШапки);
	label.УстановитьАтрибут("configuration", "com.yworks.entityRelationship.label.name");
	label.УстановитьАтрибут("fontFamily", "Dialog");
	label.УстановитьАтрибут("fontSize", "12");
	label.УстановитьАтрибут("fontStyle", "plain");
	label.УстановитьАтрибут("hasLineColor", "false");
	//label.УстановитьАтрибут("height", "20");
	label.УстановитьАтрибут("modelName", "internal");
	label.УстановитьАтрибут("modelPosition", "t");
	label.УстановитьАтрибут("textColor", "#000000");
	label.УстановитьАтрибут("visible", "true");
	//label.УстановитьАтрибут("width", "100");
	label.appendChild(XML.createTextNode(ИмяТаблицы));
	
	элРеквизит2.appendChild(label);
	
	
	
	label = XML.createElement("y:NodeLabel");
	
	label.УстановитьАтрибут("alignment", "left");
	label.УстановитьАтрибут("autoSizePolicy", "content");
	//label.УстановитьАтрибут("backgroundColor", "#99CC00");
	label.УстановитьАтрибут("configuration", "com.yworks.entityRelationship.label.attributes");
	label.УстановитьАтрибут("fontFamily", "Dialog");
	label.УстановитьАтрибут("fontSize", "10");
	label.УстановитьАтрибут("fontStyle", "plain");
	//label.УстановитьАтрибут("hasBackgroundColor", "false");
	//label.УстановитьАтрибут("hasLineColor", "false");
	//label.УстановитьАтрибут("height", "20");
	label.УстановитьАтрибут("modelName", "internal");
	label.УстановитьАтрибут("modelPosition", "l");
	label.УстановитьАтрибут("textColor", "#000000");
	label.УстановитьАтрибут("visible", "true");
	//label.УстановитьАтрибут("width", "100");	
	
	//label.appendChild(XML.createTextNode(СписокАтрибутов));
	label.appendChild(XML.createTextNode(СписокАтрибутов_HTMLформат));

	элРеквизит2.appendChild(label);


	StyleProperties = XML.createElement("y:StyleProperties");	
	элРеквизит2.appendChild(StyleProperties);
	
	Property = XML.createElement("y:Property");	
	
	Property.УстановитьАтрибут("class", "java.lang.Boolean");
	Property.УстановитьАтрибут("name", "y.view.ShadowNodePainter.SHADOW_PAINTING");
	Property.УстановитьАтрибут("value", "false");
	StyleProperties.appendChild(Property);
	
	
	
	
	
	
	элРеквизит1.ДобавитьДочерний(элРеквизит2);

КонецПроцедуры



//----- BPMN -----
Процедура ДобавитьВСхему_bpmnArtifact(XML, graph, объект1С, ИмяПодсистемы = "") экспорт
	
	цветШапки = "";
	Если Метаданные.Справочники.Содержит(объект1С) Тогда
		префикс = "спр_";
		цветШапки = "#b7c9e3";
		bpmn_type = "ARTIFACT_TYPE_DATA_STORE";
		width = "60";
		height = "55";
	ИначеЕсли Метаданные.Документы.Содержит(объект1С) Тогда
		префикс = "док_";
		цветШапки = "#ffd760";
		bpmn_type = "ARTIFACT_TYPE_DATA_OBJECT";
		width = "35";
		height = "55";
	ИначеЕсли Метаданные.РегистрыНакопления.Содержит(объект1С) Тогда		
		цветШапки = "#ff9999";
		префикс = "рн_";
		bpmn_type = "ARTIFACT_TYPE_DATA_STORE";
		width = "60";
		height = "55";
	ИначеЕсли Метаданные.РегистрыСведений.Содержит(объект1С) Тогда
		цветШапки = "#ff9999";
		префикс = "рс_";
		bpmn_type = "ARTIFACT_TYPE_DATA_STORE";
		width = "60";
		height = "55";
	ИначеЕсли Метаданные.РегистрыБухгалтерии.Содержит(объект1С) Тогда
		цветШапки = "#ff9999";
		префикс = "рб_";
		bpmn_type = "ARTIFACT_TYPE_DATA_STORE";
		width = "60";
		height = "55";
	ИначеЕсли Метаданные.ПланыВидовХарактеристик.Содержит(объект1С) Тогда
		префикс = "пвх_";
		цветШапки = "#b7c9e3";
		bpmn_type = "ARTIFACT_TYPE_DATA_STORE";
		width = "60";
		height = "55";
	КонецЕсли;
	
	ИмяТаблицы = ?(объект1С.Синоним <> "", объект1С.Синоним, объект1С.Имя);	
	СписокАтрибутов = "";
	
	н = 0;	
	МаксимальнаяДлинаИмениРеквизита = СтрДлина(ИмяТаблицы);
	СписокАтрибутов_HTMLформат = "<html>";
	Для каждого реквизит из объект1С.Реквизиты Цикл //а вдруг нет реквизитов? нужна проверка
		
		Если СтрДлина(реквизит.Имя) > МаксимальнаяДлинаИмениРеквизита Тогда
			МаксимальнаяДлинаИмениРеквизита = СтрДлина(реквизит.Имя);
		КонецЕсли;
		
		Если Справочники.ТипВсеСсылки().СодержитТип(Реквизит.Тип.Типы()[0]) 
			или Документы.ТипВсеСсылки().СодержитТип(Реквизит.Тип.Типы()[0]) Тогда			
			реквизитИмя = "(FK)" + реквизит.Имя;
			реквизитИмя_HTMLформат = "<u>" + реквизит.Имя + "</u>";
		Иначе
			реквизитИмя = реквизит.Имя;
			реквизитИмя_HTMLформат = реквизит.Имя;
		КонецЕсли;
		
		
		СписокАтрибутов = СписокАтрибутов + Символы.ПС + реквизитИмя;
		СписокАтрибутов_HTMLформат = СписокАтрибутов_HTMLформат + "<br>" + Символы.ПС + реквизитИмя_HTMLформат;		
	
		н=н+1;		
	КонецЦикла;
	
	элРеквизит = XML.СоздатьЭлемент("node");
	элРеквизит.УстановитьАтрибут("id", префикс + объект1С.Имя);	
	graph.ДобавитьДочерний(элРеквизит);
	
	элРеквизит1 = XML.СоздатьЭлемент("data");
	элРеквизит1.УстановитьАтрибут("key", "d0");			
	элРеквизит.ДобавитьДочерний(элРеквизит1);
	
	элРеквизит33 = XML.СоздатьЭлемент("data");
	элРеквизит33.УстановитьАтрибут("key", "d5");
	Если СокрЛП(ИмяПодсистемы)<>"" Тогда
		элРеквизит33.ДобавитьДочерний(XML.createTextNode(ИмяПодсистемы));
	КонецЕсли;
	элРеквизит.ДобавитьДочерний(элРеквизит33);

	элРеквизит2 = XML.СоздатьЭлемент("y:GenericNode");
	элРеквизит2.УстановитьАтрибут("configuration", "com.yworks.bpmn.Artifact");
	
	label = XML.createElement("y:Geometry");
	//label.setAttribute("height", СтрЗаменить(Строка(55 + 14*н),Символы.НПП,""));
	//label.setAttribute("width", СтрЗаменить(Строка(100 + 4*МаксимальнаяДлинаИмениРеквизита),Символы.НПП,""));
	label.setAttribute("width", width);
	label.setAttribute("height", height);
	элРеквизит2.appendChild(label);
	
	label = XML.createElement("y:Fill");
	label.setAttribute("color", "#FFFFFFE6");
	////label.setAttribute("color2", "#B7C9E3");
	label.setAttribute("transparent", "false");
	элРеквизит2.appendChild(label);
	
	label = XML.createElement("y:NodeLabel");	
	label.УстановитьАтрибут("alignment", "center");
	label.УстановитьАтрибут("autoSizePolicy", "content");
	////label.УстановитьАтрибут("backgroundColor", цветШапки);
	////label.УстановитьАтрибут("configuration", "com.yworks.entityRelationship.label.name");
	////label.УстановитьАтрибут("fontFamily", "Dialog");
	////label.УстановитьАтрибут("fontSize", "12");
	////label.УстановитьАтрибут("fontStyle", "plain");
	////label.УстановитьАтрибут("hasLineColor", "false");	
	label.УстановитьАтрибут("modelName", "sandwich");
	label.УстановитьАтрибут("modelPosition", "s");
	////label.УстановитьАтрибут("textColor", "#000000");
	////label.УстановитьАтрибут("visible", "true");	
	label.appendChild(XML.createTextNode(ИмяТаблицы));
	
	элРеквизит2.appendChild(label);
	
	Если префикс = "рс_" или префикс = "рн_" или префикс = "рб_" Тогда
		
		
		label = XML.createElement("y:NodeLabel");	
		label.УстановитьАтрибут("alignment", "center");
		label.УстановитьАтрибут("autoSizePolicy", "content");
		////label.УстановитьАтрибут("backgroundColor", цветШапки);
		////label.УстановитьАтрибут("configuration", "com.yworks.entityRelationship.label.name");
		////label.УстановитьАтрибут("fontFamily", "Dialog");
		label.УстановитьАтрибут("fontSize", "20");
		////label.УстановитьАтрибут("fontStyle", "plain");
		////label.УстановитьАтрибут("hasLineColor", "false");	
		label.УстановитьАтрибут("modelName", "internal");
		label.УстановитьАтрибут("modelPosition", "b");
		////label.УстановитьАтрибут("textColor", "#000000");
		////label.УстановитьАтрибут("visible", "true");	
		label.appendChild(XML.createTextNode(Врег(СтрЗаменить(префикс, "_", ""))));
		
		элРеквизит2.appendChild(label);
		
	КонецЕсли;
	
	
	
	
	////label = XML.createElement("y:NodeLabel");
	////
	////label.УстановитьАтрибут("alignment", "left");
	////label.УстановитьАтрибут("autoSizePolicy", "content");
	//////label.УстановитьАтрибут("backgroundColor", "#99CC00");
	////label.УстановитьАтрибут("configuration", "com.yworks.entityRelationship.label.attributes");
	////label.УстановитьАтрибут("fontFamily", "Dialog");
	////label.УстановитьАтрибут("fontSize", "10");
	////label.УстановитьАтрибут("fontStyle", "plain");
	//////label.УстановитьАтрибут("hasBackgroundColor", "false");
	//////label.УстановитьАтрибут("hasLineColor", "false");
	//////label.УстановитьАтрибут("height", "20");
	////label.УстановитьАтрибут("modelName", "internal");
	////label.УстановитьАтрибут("modelPosition", "l");
	////label.УстановитьАтрибут("textColor", "#000000");
	////label.УстановитьАтрибут("visible", "true");
	//////label.УстановитьАтрибут("width", "100");	
	////
	//////label.appendChild(XML.createTextNode(СписокАтрибутов));
	////label.appendChild(XML.createTextNode(СписокАтрибутов_HTMLформат));

	////элРеквизит2.appendChild(label);


	StyleProperties = XML.createElement("y:StyleProperties");	
	элРеквизит2.appendChild(StyleProperties);
	
			
	Property = XML.createElement("y:Property");	
	Property.УстановитьАтрибут("class", "com.yworks.yfiles.bpmn.view.BPMNTypeEnum");
	Property.УстановитьАтрибут("name", 	"com.yworks.bpmn.type");
	Property.УстановитьАтрибут("value", bpmn_type);
	StyleProperties.appendChild(Property);
		
	
		
	
	
	
	
	
	
	
	элРеквизит1.ДобавитьДочерний(элРеквизит2);
	
КонецПроцедуры
