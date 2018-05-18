subtract_Calcein = Calcein - MCalcein;
subtract_AC = AC - MAC;
subtract_DIC = DIC - MDIC;
subtract_TRAP = TRAP - MTRAP;
subtract_AP = AP - MAP;

subtract_Calcein(:,:,1) = double(imbinarize(subtract_Calcein(:,:,1), graythresh(subtract_Calcein(:,:,1))));
subtract_Calcein(:,:,2) = double(imbinarize(subtract_Calcein(:,:,2), graythresh(subtract_Calcein(:,:,2))));
subtract_Calcein(:,:,3) = double(imbinarize(subtract_Calcein(:,:,3), graythresh(subtract_Calcein(:,:,3))));

subtract_AC(:,:,1) = double(imbinarize(subtract_AC(:,:,1), graythresh(subtract_AC(:,:,1))));
subtract_AC(:,:,2) = double(imbinarize(subtract_AC(:,:,2), graythresh(subtract_AC(:,:,2))));
subtract_AC(:,:,3) = double(imbinarize(subtract_AC(:,:,3), graythresh(subtract_AC(:,:,3))));

subtract_DIC(:,:,1) = double(imbinarize(subtract_DIC(:,:,1), graythresh(subtract_DIC(:,:,1))));
subtract_DIC(:,:,2) = double(imbinarize(subtract_DIC(:,:,2), graythresh(subtract_DIC(:,:,2))));
subtract_DIC(:,:,3) = double(imbinarize(subtract_DIC(:,:,3), graythresh(subtract_DIC(:,:,3))));

subtract_TRAP(:,:,1) = double(imbinarize(subtract_TRAP(:,:,1), graythresh(subtract_TRAP(:,:,1))));
subtract_TRAP(:,:,2) = double(imbinarize(subtract_TRAP(:,:,2), graythresh(subtract_TRAP(:,:,2))));
subtract_TRAP(:,:,3) = double(imbinarize(subtract_TRAP(:,:,3), graythresh(subtract_TRAP(:,:,3))));

subtract_AP(:,:,1) = double(imbinarize(subtract_AP(:,:,1), graythresh(subtract_AP(:,:,1))));
subtract_AP(:,:,2) = double(imbinarize(subtract_AP(:,:,2), graythresh(subtract_AP(:,:,2))));
subtract_AP(:,:,3) = double(imbinarize(subtract_AP(:,:,3), graythresh(subtract_AP(:,:,3))));

subtract_Calcein = double(subtract_Calcein);
subtract_AC = double(subtract_AC);
subtract_DIC = double(subtract_DIC);
subtract_TRAP = double(subtract_TRAP);
subtract_AP = double(subtract_AP);

