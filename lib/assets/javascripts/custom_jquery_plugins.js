/*
 * inColumns jQuery Plugin
 * by Alexander Jahraus
 *
 * usage: $('li').inColumns(nCols);
 *
 * counts n elements and wraps them
 * in nCols <div>s evenly (n/nCols items per <div>)
 * 
 */
(function($) {
  
  $.fn.inColumns = function(nCols) {
    // this is a collection of items
    var nItems = this.length;
    if (nItems < nCols) {return this;}
    var perCol = Math.ceil(nItems/nCols);
    var containerWidth = 0;
    var $thisCol;

    for (var i = 0; i < nCols; i++) {
      $thisCol = this.slice(perCol * i,perCol * (i+1));
      $thisCol.wrapAll('<div>');
      containerWidth += $thisCol.parent().width();
    }
    
    $thisCol.parent().parent().width(containerWidth);
    return this;
  };
  
})(jQuery);
