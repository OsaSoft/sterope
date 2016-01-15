
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Swagger UI</title>
  <link rel="icon" type="image/png" href="images/favicon-32x32.png" sizes="32x32" />
  <link rel="icon" type="image/png" href="images/favicon-16x16.png" sizes="16x16" />
  <link href="${g.resource(file: 'dist/css/typography.css')}" media='screen' rel='stylesheet' type='text/css'/>
  <link href="${g.resource(file: 'dist/css/reset.css')}" media='screen' rel='stylesheet' type='text/css'/>
  <link href="${g.resource(file: 'dist/css/screen.css')}" media='screen' rel='stylesheet' type='text/css'/>
  <link href="${g.resource(file: 'dist/css/reset.css')}" media='print' rel='stylesheet' type='text/css'/>
  <link href="${g.resource(file: 'dist/css/print.css')}" media='print' rel='stylesheet' type='text/css'/>
  <script src="${g.resource(file: 'dist/css/lib/jquery-1.8.0.min.js')}" type='text/javascript'></script>
  <script src="${g.resource(file: 'dist/css/lib/jquery.slideto.min.js')}" type='text/javascript'></script>
  <script src="${g.resource(file: 'dist/css/lib/jquery.wiggle.min.js')}" type='text/javascript'></script>
  <script src="${g.resource(file: 'jquery.ba-bbq.min.js')}" type='text/javascript'></script>
  <script src="${g.resource(file: 'handlebars-2.0.0.js')}" type='text/javascript'></script>
  <script src="${g.resource(file: 'lib/underscore-min.js')}" type='text/javascript'></script>
  <script src="${g.resource(file: 'lib/backbone-min.js')}" type='text/javascript'></script>
  
  <script src="${g.resource(file: 'swagger-ui.jss')}" type='text/javascript'></script>
  <script src="${g.resource(file: 'lib/highlight.7.3.pack.js')}" type='text/javascript'></script>
  <script src="${g.resource(file: 'lib/jsoneditor.min.js')}" type='text/javascript'></script>
  <script src="${g.resource(file: 'lib/marked.js')}" type='text/javascript'></script>
  <script src="${g.resource(file: 'lib/swagger-oauth.js')}" type='text/javascript'></script>

  <!-- Some basic translations -->
  <!-- <script src='lang/translator.js' type='text/javascript'></script> -->
  <!-- <script src='lang/ru.js' type='text/javascript'></script> -->
  <!-- <script src='lang/en.js' type='text/javascript'></script> -->

  <script type="text/javascript">
    $(function () {
      var url = window.location.search.match(/url=([^&]+)/);
      if (url && url.length > 1) {
        url = decodeURIComponent(url[1]);
      } else {
        url = "http://petstore.swagger.io/v2/swagger.json";
      }

      // Pre load translate...
      if(window.SwaggerTranslator) {
        window.SwaggerTranslator.translate();
      }
      window.swaggerUi = new SwaggerUi({
        url: "file://${g.resource(file: 'swagger.yaml')}",
        dom_id: "swagger-ui-container",
        supportedSubmitMethods: ['get', 'post', 'put', 'delete', 'patch'],
        onComplete: function(swaggerApi, swaggerUi){
          if(typeof initOAuth == "function") {
            initOAuth({
              clientId: "your-client-id",
              clientSecret: "your-client-secret-if-required",
              realm: "your-realms",
              appName: "your-app-name", 
              scopeSeparator: ",",
              additionalQueryStringParams: {}
            });
          }

          if(window.SwaggerTranslator) {
            window.SwaggerTranslator.translate();
          }

          $('pre code').each(function(i, e) {
            hljs.highlightBlock(e)
          });

          addApiKeyAuthorization();
        },
        onFailure: function(data) {
          log("Unable to Load SwaggerUI");
        },
        docExpansion: "none",
        jsonEditor: false,
        apisSorter: "alpha",
        defaultModelRendering: 'schema',
        showRequestHeaders: false
      });

      function addApiKeyAuthorization(){
        var key = encodeURIComponent($('#input_apiKey')[0].value);
        if(key && key.trim() != "") {
            var apiKeyAuth = new SwaggerClient.ApiKeyAuthorization("api_key", key, "query");
            window.swaggerUi.api.clientAuthorizations.add("api_key", apiKeyAuth);
            log("added key " + key);
        }
      }

      $('#input_apiKey').change(addApiKeyAuthorization);

      // if you have an apiKey you would like to pre-populate on the page for demonstration purposes...
      /*
        var apiKey = "myApiKeyXXXX123456789";
        $('#input_apiKey').val(apiKey);
      */

      window.swaggerUi.load();

      function log() {
        if ('console' in window) {
          console.log.apply(console, arguments);
        }
      }
  });
  </script>
</head>

<body class="">
<div id=''>
  <div class="">
  	<!-- uiView: preview --><div ui-view="preview"><div class="preview-wrapper"><!-- ngIf: isDirty --><!-- ngIf: errors.length || warnings.length --><!-- ngInclude: undefined --><ng-include src="'templates/specs-info.html'"><div class="info"><header class="info-header"><h3 class="section-header"><a ng-click="
        specs.info.$folded = !specs.info.$folded;
        foldEditor(['info'], specs.info.$folded);
        ">Sterope API</a></h3></header><div class="info-container section-content" collapse-when="specs.info.$folded"><div marked="specs.info.description"><p>All your feeds in one place</p>
</div><h4>Version <span>1.0.0</span></h4><!-- ngIf: specs.info.contact --><!-- ngIf: specs.info.termsOfService --><!-- ngIf: specs.externalDocs --><!-- ngIf: specs.info.license --></div></div></ng-include><!-- ngIf: specs.securityDefinitions --><!-- ngInclude: undefined --><ng-include src="'templates/tags.html'"><div class="root tags"><!-- ngIf: stateParams.tags --><!-- ngIf: !stateParams.tags && getAllTags().length --><div class="all-tags" ng-if="!stateParams.tags &amp;&amp; getAllTags().length"><p>Filter operations by a tag:</p><!-- ngIf: tagsHaveDescription() --><!-- ngIf: !tagsHaveDescription() --><div ng-if="!tagsHaveDescription()"><!-- ngRepeat: tag in getAllTags() track by $index --><a href="#/?tags=Auth" ng-repeat="tag in getAllTags() track by $index" class="tag tag-color-0" ui-sref="{tags: tag.name}">Auth</a><!-- end ngRepeat: tag in getAllTags() track by $index --><a href="#/?tags=Feed" ng-repeat="tag in getAllTags() track by $index" class="tag tag-color-1" ui-sref="{tags: tag.name}">Feed</a><!-- end ngRepeat: tag in getAllTags() track by $index --></div><!-- end ngIf: !tagsHaveDescription() --></div><!-- end ngIf: !stateParams.tags && getAllTags().length --></div></ng-include><header><h3 class="section-header"><a ng-click="
          specs.paths.$folded = !specs.paths.$folded;
          foldEditor(['paths'], specs.paths.$folded);"><span>Paths</span></a> <span class="on-hover"><a ng-click="listAllOperation()">List all operations</a></span></h3></header><ul class="paths" collapse-when="specs.paths.$folded"><!-- ngRepeat: (pathName, path) in specs.paths --><!-- ngIf: showPath(path, pathName) --><!-- ngInclude:  --><li class="path" ng-include="" src="'templates/path.html'" ng-repeat="(pathName, path) in specs.paths" ng-if="showPath(path, pathName)"><header ng-click="
    path.$folded = !path.$folded;
    foldEditor(['paths', pathName], path.$folded)"><h2><a>/login</a></h2><a class="jump-to-yaml" ng-click="focusEdit($event, ['paths', pathName])" tooltip-placement="left" tooltip="Jump to YAML" tooltip-trigger="mouseenter"></a></header><ul class="operations" collapse-when="path.$folded"><!-- ngRepeat: (operationName, operation) in path --><!-- ngIf: showOperation(operation, operationName) --><li ng-repeat="(operationName, operation) in path" ng-if="showOperation(operation, operationName)" class="post operation" scroll-into-view-when="isInFocus(['paths', pathName, operationName])"><header ng-click="
      operation.$folded = !operation.$folded;
      foldEditor(['paths', pathName, operationName], operation.$folded)
    "><a class="focus-editor" ng-click="focusEdit($event, ['paths', pathName, operationName])" tooltip-placement="left" tooltip="Jump to YAML" tooltip-trigger="mouseenter"></a><div class="http-method">POST /login</div><!-- ngIf: operation.deprecated --></header><div class="content" collapse-when="operation.$folded"><div class="tags"><!-- ngRepeat: tag in operation.tags track by $index --><span class="tag tag-color-0" ng-repeat="tag in operation.tags track by $index">Auth</span><!-- end ngRepeat: tag in operation.tags track by $index --></div><!-- ngIf: operation.summary --><section class="summary" ng-if="operation.summary"><h4>Summary</h4><p>Authentication endpoint</p></section><!-- end ngIf: operation.summary --><!-- ngIf: operation.description --><section class="description" ng-if="operation.description"><h4>Description</h4><div marked="operation.description"><p>API endpoint for user authentication</p>
</div></section><!-- end ngIf: operation.description --><!-- ngIf: getParameters().length --><section class="parameters" ng-if="getParameters().length"><h4>Parameters</h4><div><table class="params"><thead><tr><th>Name</th><th>Located in</th><th>Description</th><th>Required</th><th>Schema</th></tr></thead><tbody><!-- ngRepeat: parameter in getParameters() track by $index --><tr ng-repeat="parameter in getParameters() track by $index"><td><a ng-click="focusEdit($event, [
                      'paths',
                      pathName,
                      operationName,
                      'parameters',
                      $index
                    ])" tooltip-placement="top" tooltip="Jump to YAML" tooltip-trigger="mouseenter"><span class="mono">body</span></a></td><td>body</td><td marked="parameter.description"></td><td>Yes</td><td><table schema="parameter.schema" class="schema-model" ng-class="{hidden: !schema}"><tbody><tr><td><a class="toggle" ng-click="switchMode()" title="Switch to json">⇄</a></td><td class="view json ng-hide" ng-show="mode === 'json'"><div class="json-formatter-row open">
      <a class="toggler-link">
          <span class="toggler"></span>
        <span class="value">
            <span>
              <span class="constructor-name">Object</span>
            </span>
        </span>
      </a>
      <div class="children object  "><div class="json-formatter-row">
      <a class="toggler-link">
          <span class="key">type:</span>
        <span class="value">
            <span class="string  ">"object"</span>
        </span>
      </a>
      <div class="children   "></div>
    </div><div class="json-formatter-row">
      <a class="toggler-link">
          <span class="toggler"></span>
          <span class="key">properties:</span>
        <span class="value">
            <span>
              <span class="constructor-name">Object</span>
            </span>
        </span>
      </a>
      <div class="children object  "></div>
    </div><div class="json-formatter-row">
      <a class="toggler-link">
          <span class="key">title:</span>
        <span class="value">
            <span class="string  ">"Credentials"</span>
        </span>
      </a>
      <div class="children   "></div>
    </div></div>
    </div></td><td class="view schema" ng-show="mode === 'schema'"><div class="json-schema-view"><div class="object">
          <a class="title"><span class="toggle-handle"></span>Credentials <span class="opening brace">{</span></a>
          <div class="inner">
            
          <div class="property">
          <span class="name">username:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span> </a>
            <span class="type">string</span>
        </div></div></div></div>
          <span class="closing brace">}</span>
        </div></div></td></tr></tbody></table></td></tr><!-- end ngRepeat: parameter in getParameters() track by $index --></tbody></table></div></section><!-- end ngIf: getParameters().length --><!-- ngIf: operation --><section class="responses" ng-if="operation"><h4>Responses</h4><div><table class="respns"><thead><tr><th>Code</th><th>Description</th><!-- ngIf: hasAResponseWithHeaders(operation.responses) --><!-- ngIf: hasAResponseWithSchema(operation.responses) --><th ng-if="hasAResponseWithSchema(operation.responses)">Schema</th><!-- end ngIf: hasAResponseWithSchema(operation.responses) --></tr></thead><tbody><!-- ngRepeat: (responseCode, response) in operation.responses --><tr ng-repeat="(responseCode, response) in operation.responses"><td><a ng-click="focusEdit($event, [
                    'paths',
                    pathName,
                    operationName,
                    'responses',
                    responseCode])" tooltip-placement="top" tooltip="Jump to YAML" tooltip-trigger="mouseenter"><span class="resp-code green">200</span></a></td><td marked="response.description"><p>Authentication was succesfull.</p>
</td><!-- ngIf: hasAResponseWithHeaders(operation.responses) --><!-- ngIf: hasAResponseWithSchema(operation.responses) --><td ng-if="hasAResponseWithSchema(operation.responses)"><!-- ngIf: response.schema --><table ng-if="response.schema" schema="response.schema" class="schema-model" ng-class="{hidden: !schema}"><tbody><tr><td><a class="toggle" ng-click="switchMode()" title="Switch to json">⇄</a></td><td class="view json ng-hide" ng-show="mode === 'json'"><div class="json-formatter-row open">
      <a class="toggler-link">
          <span class="toggler"></span>
        <span class="value">
            <span>
              <span class="constructor-name">Object</span>
            </span>
        </span>
      </a>
      <div class="children object  "><div class="json-formatter-row">
      <a class="toggler-link">
          <span class="key">type:</span>
        <span class="value">
            <span class="string  ">"object"</span>
        </span>
      </a>
      <div class="children   "></div>
    </div><div class="json-formatter-row">
      <a class="toggler-link">
          <span class="toggler"></span>
          <span class="key">properties:</span>
        <span class="value">
            <span>
              <span class="constructor-name">Object</span>
            </span>
        </span>
      </a>
      <div class="children object  "></div>
    </div><div class="json-formatter-row">
      <a class="toggler-link">
          <span class="key">title:</span>
        <span class="value">
            <span class="string  ">"Token"</span>
        </span>
      </a>
      <div class="children   "></div>
    </div></div>
    </div></td><td class="view schema" ng-show="mode === 'schema'"><div class="json-schema-view"><div class="object">
          <a class="title"><span class="toggle-handle"></span>Token <span class="opening brace">{</span></a>
          <div class="inner">
            
          <div class="property">
          <span class="name">username:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span> </a>
            <span class="type">string</span>
        </div></div></div><div class="property">
          <span class="name">roles:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span>Role </a>
            <span class="type">string</span>
        </div></div></div><div class="property">
          <span class="name">token_type:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span> </a>
            <span class="type">string</span>
        </div></div></div><div class="property">
          <span class="name">access_token:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span> </a>
            <span class="type">string</span>
        </div></div></div><div class="property">
          <span class="name">expires_in:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span> </a>
            <span class="type">integer</span>
        </div></div></div><div class="property">
          <span class="name">refresh_token:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span> </a>
            <span class="type">string</span>
        </div></div></div></div>
          <span class="closing brace">}</span>
        </div></div></td></tr></tbody></table><!-- end ngIf: response.schema --></td><!-- end ngIf: hasAResponseWithSchema(operation.responses) --></tr><!-- end ngRepeat: (responseCode, response) in operation.responses --><tr ng-repeat="(responseCode, response) in operation.responses"><td><a ng-click="focusEdit($event, [
                    'paths',
                    pathName,
                    operationName,
                    'responses',
                    responseCode])" tooltip-placement="top" tooltip="Jump to YAML" tooltip-trigger="mouseenter"><span class="resp-code yellow">401</span></a></td><td marked="response.description"><p>Incorrect credentials</p>
</td><!-- ngIf: hasAResponseWithHeaders(operation.responses) --><!-- ngIf: hasAResponseWithSchema(operation.responses) --><td ng-if="hasAResponseWithSchema(operation.responses)"><!-- ngIf: response.schema --></td><!-- end ngIf: hasAResponseWithSchema(operation.responses) --></tr><!-- end ngRepeat: (responseCode, response) in operation.responses --></tbody></table></div></section><!-- end ngIf: operation --><!-- ngIf: operation.security && operation.security.length --><!-- ngIf: enableTryIt --><section class="try-operation" ng-if="enableTryIt"><!-- ngIf: !isTryOpen --><button class="border-only try-it" ng-class="{trying: isTryOpen}" ng-click="toggleTry()" ng-if="!isTryOpen" track-event="try-operation">Try this operation</button><!-- end ngIf: !isTryOpen --> <!-- ngIf: isTryOpen --><!-- ngIf: isTryOpen --></section><!-- end ngIf: enableTryIt --></div></li><!-- end ngIf: showOperation(operation, operationName) --><!-- end ngRepeat: (operationName, operation) in path --></ul></li><!-- end ngIf: showPath(path, pathName) --><!-- end ngRepeat: (pathName, path) in specs.paths --><!-- ngIf: showPath(path, pathName) --><!-- ngInclude:  --><li class="path" ng-include="" src="'templates/path.html'" ng-repeat="(pathName, path) in specs.paths" ng-if="showPath(path, pathName)"><header ng-click="
    path.$folded = !path.$folded;
    foldEditor(['paths', pathName], path.$folded)"><h2><a>/feed</a></h2><a class="jump-to-yaml" ng-click="focusEdit($event, ['paths', pathName])" tooltip-placement="left" tooltip="Jump to YAML" tooltip-trigger="mouseenter"></a></header><ul class="operations" collapse-when="path.$folded"><!-- ngRepeat: (operationName, operation) in path --><!-- ngIf: showOperation(operation, operationName) --><li ng-repeat="(operationName, operation) in path" ng-if="showOperation(operation, operationName)" class="get operation" scroll-into-view-when="isInFocus(['paths', pathName, operationName])"><header ng-click="
      operation.$folded = !operation.$folded;
      foldEditor(['paths', pathName, operationName], operation.$folded)
    "><a class="focus-editor" ng-click="focusEdit($event, ['paths', pathName, operationName])" tooltip-placement="left" tooltip="Jump to YAML" tooltip-trigger="mouseenter"></a><div class="http-method">GET /feed</div><!-- ngIf: operation.deprecated --></header><div class="content" collapse-when="operation.$folded"><div class="tags"><!-- ngRepeat: tag in operation.tags track by $index --><span class="tag tag-color-1" ng-repeat="tag in operation.tags track by $index">Feed</span><!-- end ngRepeat: tag in operation.tags track by $index --></div><!-- ngIf: operation.summary --><section class="summary" ng-if="operation.summary"><h4>Summary</h4><p>User feed</p></section><!-- end ngIf: operation.summary --><!-- ngIf: operation.description --><section class="description" ng-if="operation.description"><h4>Description</h4><div marked="operation.description"><p>Individual items in the user's feed</p>
</div></section><!-- end ngIf: operation.description --><!-- ngIf: getParameters().length --><section class="parameters" ng-if="getParameters().length"><h4>Parameters</h4><div><table class="params"><thead><tr><th>Name</th><th>Located in</th><th>Description</th><th>Required</th><th>Schema</th></tr></thead><tbody><!-- ngRepeat: parameter in getParameters() track by $index --><tr ng-repeat="parameter in getParameters() track by $index"><td><a ng-click="focusEdit($event, [
                      'paths',
                      pathName,
                      operationName,
                      'parameters',
                      $index
                    ])" tooltip-placement="top" tooltip="Jump to YAML" tooltip-trigger="mouseenter"><span class="mono">Authorization</span></a></td><td>header</td><td marked="parameter.description"><p>Bearer token required for authorization</p>
</td><td>Yes</td><td><table schema="parameter.schema" class="schema-model" ng-class="{hidden: !schema}"><tbody><tr><td><a class="toggle" ng-click="switchMode()" title="Switch to json">⇄</a></td><td class="view json ng-hide" ng-show="mode === 'json'"><div class="json-formatter-row open">
      <a class="toggler-link">
          <span class="toggler"></span>
        <span class="value">
            <span>
              <span class="constructor-name">Object</span>
            </span>
        </span>
      </a>
      <div class="children object  "><div class="json-formatter-row">
      <a class="toggler-link">
          <span class="key">type:</span>
        <span class="value">
            <span class="string  ">"string"</span>
        </span>
      </a>
      <div class="children   "></div>
    </div></div>
    </div></td><td class="view schema" ng-show="mode === 'schema'"><div class="json-schema-view"><div class="primitive">
            <span class="type">string</span>
        </div></div></td></tr></tbody></table></td></tr><!-- end ngRepeat: parameter in getParameters() track by $index --></tbody></table></div></section><!-- end ngIf: getParameters().length --><!-- ngIf: operation --><section class="responses" ng-if="operation"><h4>Responses</h4><div><table class="respns"><thead><tr><th>Code</th><th>Description</th><!-- ngIf: hasAResponseWithHeaders(operation.responses) --><!-- ngIf: hasAResponseWithSchema(operation.responses) --><th ng-if="hasAResponseWithSchema(operation.responses)">Schema</th><!-- end ngIf: hasAResponseWithSchema(operation.responses) --></tr></thead><tbody><!-- ngRepeat: (responseCode, response) in operation.responses --><tr ng-repeat="(responseCode, response) in operation.responses"><td><a ng-click="focusEdit($event, [
                    'paths',
                    pathName,
                    operationName,
                    'responses',
                    responseCode])" tooltip-placement="top" tooltip="Jump to YAML" tooltip-trigger="mouseenter"><span class="resp-code green">200</span></a></td><td marked="response.description"><p>An array of user's feed items</p>
</td><!-- ngIf: hasAResponseWithHeaders(operation.responses) --><!-- ngIf: hasAResponseWithSchema(operation.responses) --><td ng-if="hasAResponseWithSchema(operation.responses)"><!-- ngIf: response.schema --><table ng-if="response.schema" schema="response.schema" class="schema-model" ng-class="{hidden: !schema}"><tbody><tr><td><a class="toggle" ng-click="switchMode()" title="Switch to json">⇄</a></td><td class="view json ng-hide" ng-show="mode === 'json'"><div class="json-formatter-row open">
      <a class="toggler-link">
          <span class="toggler"></span>
        <span class="value">
            <span>
              <span class="constructor-name">Object</span>
            </span>
        </span>
      </a>
      <div class="children object  "><div class="json-formatter-row">
      <a class="toggler-link">
          <span class="key">type:</span>
        <span class="value">
            <span class="string  ">"array"</span>
        </span>
      </a>
      <div class="children   "></div>
    </div><div class="json-formatter-row">
      <a class="toggler-link">
          <span class="toggler"></span>
          <span class="key">items:</span>
        <span class="value">
            <span>
              <span class="constructor-name">Object</span>
            </span>
        </span>
      </a>
      <div class="children object  "></div>
    </div></div>
    </div></td><td class="view schema" ng-show="mode === 'schema'"><div class="json-schema-view"><div class="array">
          <a class="title"><span class="toggle-handle"></span><span class="opening bracket">[</span></a>
          <div class="inner">
          <div class="json-schema-view"><div class="object">
          <a class="title"><span class="toggle-handle"></span>FeedItem <span class="opening brace">{</span></a>
          <div class="inner">
            
          <div class="property">
          <span class="name">date:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span> </a>
            <span class="type">string</span>
        </div></div></div><div class="property">
          <span class="name">feedName:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span> </a>
            <span class="type">string</span>
        </div></div></div><div class="property">
          <span class="name">link:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span> </a>
            <span class="type">string</span>
        </div></div></div><div class="property">
          <span class="name">title:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span> </a>
            <span class="type">string</span>
        </div></div></div></div>
          <span class="closing brace">}</span>
        </div></div></div>
          <span class="closing bracket">]</span>
        </div></div></td></tr></tbody></table><!-- end ngIf: response.schema --></td><!-- end ngIf: hasAResponseWithSchema(operation.responses) --></tr><!-- end ngRepeat: (responseCode, response) in operation.responses --><tr ng-repeat="(responseCode, response) in operation.responses"><td><a ng-click="focusEdit($event, [
                    'paths',
                    pathName,
                    operationName,
                    'responses',
                    responseCode])" tooltip-placement="top" tooltip="Jump to YAML" tooltip-trigger="mouseenter"><span class="resp-code yellow">401</span></a></td><td marked="response.description"><p>Token is missing or incorrect</p>
</td><!-- ngIf: hasAResponseWithHeaders(operation.responses) --><!-- ngIf: hasAResponseWithSchema(operation.responses) --><td ng-if="hasAResponseWithSchema(operation.responses)"><!-- ngIf: response.schema --></td><!-- end ngIf: hasAResponseWithSchema(operation.responses) --></tr><!-- end ngRepeat: (responseCode, response) in operation.responses --></tbody></table></div></section><!-- end ngIf: operation --><!-- ngIf: operation.security && operation.security.length --><!-- ngIf: enableTryIt --><section class="try-operation" ng-if="enableTryIt"><!-- ngIf: !isTryOpen --><button class="border-only try-it" ng-class="{trying: isTryOpen}" ng-click="toggleTry()" ng-if="!isTryOpen" track-event="try-operation">Try this operation</button><!-- end ngIf: !isTryOpen --> <!-- ngIf: isTryOpen --><!-- ngIf: isTryOpen --></section><!-- end ngIf: enableTryIt --></div></li><!-- end ngIf: showOperation(operation, operationName) --><!-- end ngRepeat: (operationName, operation) in path --></ul></li><!-- end ngIf: showPath(path, pathName) --><!-- end ngRepeat: (pathName, path) in specs.paths --></ul><!-- ngIf: specs.definitions --><header ng-if="specs.definitions"><h3 class="section-header"><a ng-click="
        specs.definitions.$folded = !specs.definitions.$folded;
        foldEditor(['definitions'], specs.definitions.$folded);
      ">Models</a> <span class="on-hover"><a ng-click="listAllDefnitions()">List all models</a></span></h3></header><!-- end ngIf: specs.definitions --><!-- ngIf: showDefinitions(specs.definitions) --><ul class="section-content definitions" ng-if="showDefinitions(specs.definitions)" collapse-when="specs.definitions.$folded"><!-- ngRepeat: (modelName, model) in specs.definitions --><!-- ngIf: !isVendorExtension(modelName) --><li class="definition" ng-repeat="(modelName, model) in specs.definitions" ng-if="!isVendorExtension(modelName)" scroll-into-view-when="isInFocus(['definitions', modelName])"><h4><a ng-click="
              model.$folded = !model.$folded;
              foldEditor(['definitions', modelName], model.$folded)
            " class="definition-title">Credentials</a></h4><div collapse-when="model.$folded"><table schema="model" class="schema-model" ng-class="{hidden: !schema}"><tbody><tr><td><a class="toggle" ng-click="switchMode()" title="Switch to json">⇄</a></td><td class="view json ng-hide" ng-show="mode === 'json'"><div class="json-formatter-row open">
      <a class="toggler-link">
          <span class="toggler"></span>
        <span class="value">
            <span>
              <span class="constructor-name">Object</span>
            </span>
        </span>
      </a>
      <div class="children object  "><div class="json-formatter-row">
      <a class="toggler-link">
          <span class="key">type:</span>
        <span class="value">
            <span class="string  ">"object"</span>
        </span>
      </a>
      <div class="children   "></div>
    </div><div class="json-formatter-row">
      <a class="toggler-link">
          <span class="toggler"></span>
          <span class="key">properties:</span>
        <span class="value">
            <span>
              <span class="constructor-name">Object</span>
            </span>
        </span>
      </a>
      <div class="children object  "></div>
    </div><div class="json-formatter-row">
      <a class="toggler-link">
          <span class="key">title:</span>
        <span class="value">
            <span class="string  ">"Credentials"</span>
        </span>
      </a>
      <div class="children   "></div>
    </div></div>
    </div></td><td class="view schema" ng-show="mode === 'schema'"><div class="json-schema-view"><div class="object">
          <a class="title"><span class="toggle-handle"></span>Credentials <span class="opening brace">{</span></a>
          <div class="inner">
            
          <div class="property">
          <span class="name">username:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span> </a>
            <span class="type">string</span>
        </div></div></div></div>
          <span class="closing brace">}</span>
        </div></div></td></tr></tbody></table></div></li><!-- end ngIf: !isVendorExtension(modelName) --><!-- end ngRepeat: (modelName, model) in specs.definitions --><!-- ngIf: !isVendorExtension(modelName) --><li class="definition" ng-repeat="(modelName, model) in specs.definitions" ng-if="!isVendorExtension(modelName)" scroll-into-view-when="isInFocus(['definitions', modelName])"><h4><a ng-click="
              model.$folded = !model.$folded;
              foldEditor(['definitions', modelName], model.$folded)
            " class="definition-title">FeedItem</a></h4><div collapse-when="model.$folded"><table schema="model" class="schema-model" ng-class="{hidden: !schema}"><tbody><tr><td><a class="toggle" ng-click="switchMode()" title="Switch to json">⇄</a></td><td class="view json ng-hide" ng-show="mode === 'json'"><div class="json-formatter-row open">
      <a class="toggler-link">
          <span class="toggler"></span>
        <span class="value">
            <span>
              <span class="constructor-name">Object</span>
            </span>
        </span>
      </a>
      <div class="children object  "><div class="json-formatter-row">
      <a class="toggler-link">
          <span class="key">type:</span>
        <span class="value">
            <span class="string  ">"object"</span>
        </span>
      </a>
      <div class="children   "></div>
    </div><div class="json-formatter-row">
      <a class="toggler-link">
          <span class="toggler"></span>
          <span class="key">properties:</span>
        <span class="value">
            <span>
              <span class="constructor-name">Object</span>
            </span>
        </span>
      </a>
      <div class="children object  "></div>
    </div><div class="json-formatter-row">
      <a class="toggler-link">
          <span class="key">title:</span>
        <span class="value">
            <span class="string  ">"FeedItem"</span>
        </span>
      </a>
      <div class="children   "></div>
    </div></div>
    </div></td><td class="view schema" ng-show="mode === 'schema'"><div class="json-schema-view"><div class="object">
          <a class="title"><span class="toggle-handle"></span>FeedItem <span class="opening brace">{</span></a>
          <div class="inner">
            
          <div class="property">
          <span class="name">date:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span> </a>
            <span class="type">string</span>
        </div></div></div><div class="property">
          <span class="name">feedName:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span> </a>
            <span class="type">string</span>
        </div></div></div><div class="property">
          <span class="name">link:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span> </a>
            <span class="type">string</span>
        </div></div></div><div class="property">
          <span class="name">title:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span> </a>
            <span class="type">string</span>
        </div></div></div></div>
          <span class="closing brace">}</span>
        </div></div></td></tr></tbody></table></div></li><!-- end ngIf: !isVendorExtension(modelName) --><!-- end ngRepeat: (modelName, model) in specs.definitions --><!-- ngIf: !isVendorExtension(modelName) --><li class="definition" ng-repeat="(modelName, model) in specs.definitions" ng-if="!isVendorExtension(modelName)" scroll-into-view-when="isInFocus(['definitions', modelName])"><h4><a ng-click="
              model.$folded = !model.$folded;
              foldEditor(['definitions', modelName], model.$folded)
            " class="definition-title">Role</a></h4><div collapse-when="model.$folded"><table schema="model" class="schema-model" ng-class="{hidden: !schema}"><tbody><tr><td><a class="toggle" ng-click="switchMode()" title="Switch to json">⇄</a></td><td class="view json ng-hide" ng-show="mode === 'json'"><div class="json-formatter-row open">
      <a class="toggler-link">
          <span class="toggler"></span>
        <span class="value">
            <span>
              <span class="constructor-name">Object</span>
            </span>
        </span>
      </a>
      <div class="children object  "><div class="json-formatter-row">
      <a class="toggler-link">
          <span class="key">type:</span>
        <span class="value">
            <span class="string  ">"string"</span>
        </span>
      </a>
      <div class="children   "></div>
    </div><div class="json-formatter-row">
      <a class="toggler-link">
          <span class="key">title:</span>
        <span class="value">
            <span class="string  ">"Role"</span>
        </span>
      </a>
      <div class="children   "></div>
    </div></div>
    </div></td><td class="view schema" ng-show="mode === 'schema'"><div class="json-schema-view"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span>Role </a>
            <span class="type">string</span>
        </div></div></td></tr></tbody></table></div></li><!-- end ngIf: !isVendorExtension(modelName) --><!-- end ngRepeat: (modelName, model) in specs.definitions --><!-- ngIf: !isVendorExtension(modelName) --><li class="definition" ng-repeat="(modelName, model) in specs.definitions" ng-if="!isVendorExtension(modelName)" scroll-into-view-when="isInFocus(['definitions', modelName])"><h4><a ng-click="
              model.$folded = !model.$folded;
              foldEditor(['definitions', modelName], model.$folded)
            " class="definition-title">Token</a></h4><div collapse-when="model.$folded"><table schema="model" class="schema-model" ng-class="{hidden: !schema}"><tbody><tr><td><a class="toggle" ng-click="switchMode()" title="Switch to json">⇄</a></td><td class="view json ng-hide" ng-show="mode === 'json'"><div class="json-formatter-row open">
      <a class="toggler-link">
          <span class="toggler"></span>
        <span class="value">
            <span>
              <span class="constructor-name">Object</span>
            </span>
        </span>
      </a>
      <div class="children object  "><div class="json-formatter-row">
      <a class="toggler-link">
          <span class="key">type:</span>
        <span class="value">
            <span class="string  ">"object"</span>
        </span>
      </a>
      <div class="children   "></div>
    </div><div class="json-formatter-row">
      <a class="toggler-link">
          <span class="toggler"></span>
          <span class="key">properties:</span>
        <span class="value">
            <span>
              <span class="constructor-name">Object</span>
            </span>
        </span>
      </a>
      <div class="children object  "></div>
    </div><div class="json-formatter-row">
      <a class="toggler-link">
          <span class="key">title:</span>
        <span class="value">
            <span class="string  ">"Token"</span>
        </span>
      </a>
      <div class="children   "></div>
    </div></div>
    </div></td><td class="view schema" ng-show="mode === 'schema'"><div class="json-schema-view"><div class="object">
          <a class="title"><span class="toggle-handle"></span>Token <span class="opening brace">{</span></a>
          <div class="inner">
            
          <div class="property">
          <span class="name">username:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span> </a>
            <span class="type">string</span>
        </div></div></div><div class="property">
          <span class="name">roles:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span>Role </a>
            <span class="type">string</span>
        </div></div></div><div class="property">
          <span class="name">token_type:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span> </a>
            <span class="type">string</span>
        </div></div></div><div class="property">
          <span class="name">access_token:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span> </a>
            <span class="type">string</span>
        </div></div></div><div class="property">
          <span class="name">expires_in:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span> </a>
            <span class="type">integer</span>
        </div></div></div><div class="property">
          <span class="name">refresh_token:</span>
        <div class="json-schema-view collapsed"><div class="primitive">
            <a class="title"><span class="toggle-handle"></span> </a>
            <span class="type">string</span>
        </div></div></div></div>
          <span class="closing brace">}</span>
        </div></div></td></tr></tbody></table></div></li><!-- end ngIf: !isVendorExtension(modelName) --><!-- end ngRepeat: (modelName, model) in specs.definitions --></ul><!-- end ngIf: showDefinitions(specs.definitions) --></div></div>
  </div>
</div>

<div id="message-bar" class="swagger-ui-wrap" data-sw-translate>&nbsp;</div>
<div id="swagger-ui-container" class="swagger-ui-wrap"></div>
</body>
</html>