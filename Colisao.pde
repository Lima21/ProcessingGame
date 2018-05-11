// deteta colisao
// cordenadas + diaetro


boolean circuloCirculo(float x1, float y1, float d1, float x2, float y2, float d2) {
  if(d1/2 + d2/2 > dist(x1, y1, x2, y2))
  return true;
  else
  return false;
}