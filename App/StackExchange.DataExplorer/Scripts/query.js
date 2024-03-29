﻿
(function ($) {

    $.fn.tabs = function () {

        var findContentDiv = function (aTag) {
            return $("#" + aTag.href.split("#")[1]);
        }

        var tabDiv = this;

        $.each($(this).children(), function () {
            $(this).click(function () {
                if (!$(this).hasClass("youarehere")) {
                    $.each($(tabDiv).children(), function () {
                        if ($(this).hasClass("youarehere")) {
                            $(this).removeClass("youarehere");
                            findContentDiv(this).hide();
                        }
                    });
                    $(this).addClass("youarehere");
                    findContentDiv(this).show();
                }
                return false;
            });
        });
    };
})(jQuery);


function encodeColumn(s) {
    if (s != null && s.replace != null) {
        s = s.replace(/[\n\r]/g, " ")
              .replace(/&(?!\w+([;\s]|$))/g, "&amp;")
              .replace(/</g, "&lt;")
              .replace(/>/g, "&gt;")
              .substring(0, 400);
        return s;
    } else {
        return s;
    }
}

function splitTags(s) {
    if (s == null) return [];
    var tmp = s.split("<");
    var rval = [];
    for (var i = 0; i < tmp.length; i++) {
        if (tmp[i] != "") {
            rval.push(tmp[i].replace(">", ""));
        }
    }

    return rval;
}

var current_results;

function scrollToResults() {
    var target_offset = $("#toolbar").offset();
    var target_top = target_offset.top - 10;
    $('html, body').animate({ scrollTop: target_top }, 500);
}

// this is from SO 901115
function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
    var regexS = "[\\?&]" + name + "=([^&#]*)";
    var regex = new RegExp(regexS);
    var results = regex.exec(window.location.href);
    if (results == null)
        return "";
    else
        return results[1];
}

function populateParamsFromUrl() {
    $('#queryParams').find("p input").each(function () {
        var val = getParameterByName(this.name);
        if (val != null && val.length > 0) {
            $(this).val(getParameterByName(this.name));
        }
    });
}

function gotResults(results) {
    current_results = results;

    $('form input[type=submit]').attr('disabled', null);
    $(".loading").hide();

    if (results.error != null) {
        $("#queryErrorBox").show();
        $("#queryError").html(results.error);
        return;
    }

    if (results.truncated == true) {
        $("#queryErrorBox").show();
        $("#queryError").html("Your query was truncated, only " + results.maxResults + " results are allowed");
    }

    $("#messages pre code").text(results.messages);

    var currentParams = "?";
    currentParams += $('#queryParams').find("p input").serialize();

    if (currentParams == "?") {
        currentParams = "";
    }

    $("#permalinks").show();
    var currentLink = $("#permalink")[0];

    var linkId = results.queryId;
    var slug = results.slug == null ? "/" : "/" + slug;
    var linkPath = results.textOnly ? "qt" : "q";
    if (window.queryId !== undefined) {
        linkId = queryId;
        slug = "/" + querySlug;
        linkPath = results.textOnly ? "st" : "s";
    }

    currentLink.href = "/" + results.siteName + "/"+ linkPath + "/" + linkId + slug + currentParams;

    $("#downloadCsv")[0].href = "/" + results.siteName + "/csv/" + results.queryId + currentParams;

    $(".otherPermalink").each(function () {
        // slug
        this.href = this.href.substring(0, this.href.lastIndexOf("/"));
        // query id
        this.href = this.href.substring(0, this.href.lastIndexOf("/"));
        // type
        this.href = this.href.substring(0, this.href.lastIndexOf("/") + 1) + linkPath + "/" + linkId + slug;
    });

    $("#gridStats .duration").text("Duration: " + results.executionTime + "ms");

    if (results.textOnly || results.resultSets.length == 0) {
        $("#resultTabs").hide();
        $("#messages").show();
        $("#queryResults").show();
        $("#grid").hide();
        return;
    }

    $("#grid").show();
    $("#resultTabs").show();
    $("#messages").hide();

    var model = [];
    var maxWidths = [];
    for (var c = 0; c < results.resultSets[0].columns.length; c++) {
        model.push({
            width: 60, 
            cssClass: (results.resultSets[0].columns[c].type == "Number" ? "number" : "text"),
            id: results.resultSets[0].columns[c].name,
            name: results.resultSets[0].columns[c].name,
            field: c
        });
        maxWidths.push(results.resultSets[0].columns[c].name.length);
    }


    var rows = [];
    var hasTags = false;

    for (var i = 0; i < results.resultSets[0].rows.length; i++) {
        var row = {};
        var data = null;
        for (var c = 0; c < results.resultSets[0].columns.length; c++) {
            var col = results.resultSets[0].rows[i][c];
            if (col != null && col.title != null && col.id != null) {
                var isUser = (results.resultSets[0].columns[c].type == "User");
                data = ("<a href=\"" + results.url + (isUser ? "/users/" : "/questions/") +
                col.id + "\">" + encodeColumn(col.title) + "</a>");
                if (col.title.length > maxWidths[c]) maxWidths[c] = col.title.length;
            } else if (model[c].field == "Tags" || model[c].field == "TagName") {
                // smart rendering of tags 
                var tags = splitTags(col);
                var tmpLength = tags.join(" ").length;
                if (col != null && tmpLength > maxWidths[c]) maxWidths[c] = tmpLength;
                for (var tagIndex = 0; tagIndex < tags.length; tagIndex++) {
                    tags[tagIndex] = "<a class=\"post-tag\" href=\"" + results.url + "/tags/" + tags[tagIndex] + "\">" + tags[tagIndex] + "</a>";
                };
                data = tags.join(" ");
                hasTags = true;
            } else {
                data = (encodeColumn(col));
                if (col != null && col.toString().length > maxWidths[c]) maxWidths[c] = col.toString().length;
            }
            row[c] = data;
        }
        rows.push(row);

    }

    for (var i = 0; i < model.length; i++) {
        model[i].width = maxWidths[i] * 12 > 250 ? 300 : 8 + maxWidths[i] * 12;
    }

    $("#queryResults").show();
    $("#gridStats .rows").text("" + rows.length + " row" + (rows.length == 1 ? "" : "s"));


    var options = {
        enableCellNavigation: false,
        enableColumnReorder: false,
        rowHeight: hasTags ? 35 : 25
    };

    new Slick.Grid($("#grid"), rows, model, options);

    scrollToResults();

}

function executeQuery(sql) {

    $("#permalinks").hide();
    $("#queryResults").hide();
    $("#queryErrorBox").hide();

    if (!ensureAllParamsEntered(sql)) {
        return false;
    }

    $(".loading").show();
    $('#runQueryForm input[type=submit]', this).attr('disabled', 'disabled');

    $.ajax({
        cache: false
          , url: $('#runQueryForm')[0].action
          , type: "POST"
          , data: $("#runQueryForm").serialize()
          , error: function () {
              alert("Something is wrong with the server!");
          }
          , success: gotResults
    });

    return false;
}

function ensureAllParamsEntered(query) {
    var pattern = /##[a-zA-Z0-9]+##/g;
    var params = query.match(pattern);
    if (params == null) params = [];

    var div = $('#queryParams');

    var allParamsHaveValues = true;

    for (var i = 0; i < params.length; i++) {
        params[i] = params[i].substring(2, params[i].length - 2);

        var currentParam = div.find("input[name=" + params[i] + "]");
        if (currentParam.length == 0) {
            div.append("<p><label>" + params[i] + "</label>\n" +
            "<input type=\"text\" name=\"" + params[i] + "\" value=\"\" /><div class='clear'></div></p>");
            allParamsHaveValues = false;
        } else {
            if (currentParam.val().length == 0) {
                allParamsHaveValues = false;
            }
        }
    }

    // remove extra params
    div.children("p").each(function () {
        var name = $(this).find('input').attr('name');
        var found = false;
        for (var i = 0; i < params.length; i++) {
            found = params[i] == name;
            if (found) break;
        }
        if (!found) {
            $(this).remove();
        } else {
            // auto param 
            if ($(this).find('input').val().length == 0 && name == "UserId") {
                $(this).find('input').val(guessedUserId);
            }
        }
    });

    if (params.length > 0) {
        div.show();
    } else {
        div.hide();
    }

    if (params.length > 0 && !allParamsHaveValues) {
        div.find('input:first').focus();
    }

    return allParamsHaveValues;
}

function forwardEvent(event, element) {
    if (event == "focus") {
        $(".CodeMirror-wrapping").addClass("focus");
    }
    if (event == "blur") {
        $(".CodeMirror-wrapping").removeClass("focus");
    }
}