class DataController < ApplicationController
  @thegroups=[]
  def enter
  end

  def search
    query="%"+params[:search]+"%";
    @auto=[];
    @theautos=City.where('name LIKE ?',query).limit(15).pluck(:name,:country_id).sort();
    @theautos.each do |theauto|
        theauto[1]=Country.find(theauto[1]).name;
        newele=theauto[0]+', '+theauto[1];
        puts newele.inspect
      @auto.push(newele);
    end
     puts @auto.inspect
    # puts @thegroups.inspect


  end

  def getdata
    thelong=search_params[:lang]
    thelat=search_params[:lat]
    thedist=search_params[:thedistance]
    if(thelong=='non' || thelat=='non')
      thecith=search_params[:theselected].split(',',2)[0];
      thecoun=search_params[:theselected].split(',',2)[1].split(' ',2)[0];
      theconid=Country.find_by('name = ?',thecoun).id;
      puts City.where('name = ? and country_id = ?',thecith,theconid).inspect
      thelat=City.where('name = ? and country_id = ?',thecith,theconid)[0].lat
      thelong=City.where('name = ? and country_id = ?',thecith,theconid)[0].long
      puts thelat.inspect
      puts thelong.inspect
    end
    @allgroups=Group.select("*,3956 * 2 * ASIN(SQRT( POWER(SIN((#{thelat} -abs(groups.lat)) * pi()/180 / 2),2) + COS(#{thelat} * pi()/180 ) * COS(abs(groups.lat) *  pi()/180) * POWER(SIN((#{thelong} - groups.long) *  pi()/180 / 2), 2) )) as distance").having("distance < #{thedist}").order('distance').limit(10);
    @thegroups=@allgroups;
    puts @allgroups.inspect
    #render json: @allgroups
    # set @orig_lat=31.264112799999996; set @orig_lon=29.999791100000003;
    # set @dist=10;
    # "SELECT *,3956 * 2 * ASIN(SQRT( POWER(SIN((@orig_lat - abs( groups.lat)) * pi()/180 / 2),2) + COS(@orig_lat * pi()/180 ) * COS( abs(groups.lat) *  pi()/180) * POWER(SIN((@orig_lon - groups.long) *  pi()/180 / 2), 2) )) as distance FROM groups having distance < @dist ORDER BY distance limit 10;"
    puts search_params.inspect

  end
  private
  def search_params
    params.permit(:lang, :lat,:theselected,:thedistance)
  end
end
