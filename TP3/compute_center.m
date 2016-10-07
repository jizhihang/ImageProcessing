function [halfRow,halfCol] = compute_center(nRow, nCol)
  if (mod(nRow, 2) == 1)
    halfRow = (nRow -1) / 2;    
  else
    halfRow = nRow / 2;  
  end
  if (mod(nCol, 2) == 1)
    halfCol = (nCol - 1) / 2;
  else
    halfCol = nCol / 2;
  end
end


