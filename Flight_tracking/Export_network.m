%%filename = 'yolov2.onnx';
%exportONNXNetwork(detector,filename);
%save('trainedDetector.mat', 'detector');
img = imread("/MATLAB Drive/FlyingObjectDetection/Data/Training_data_V/V_AIRPLANE_0327_121.png");
[bboxes,scores,labels] = detect(detector,img, 'Threshold', 0.14);
disp('Confidence Scores:');
disp(scores);

if ~isempty(scores)
    [~, idx] = max(scores); 
    highest_conf_bbox = bboxes(idx, :);
    highest_conf_label = labels{idx};

    detectedImg = insertObjectAnnotation(img, 'Rectangle', highest_conf_bbox, highest_conf_label);
    figure;
    imshow(detectedImg);

    disp(['Highest Confidence Score: ' num2str(scores(idx))]);
else
    disp('No detections above the threshold.');
end


filename = 'yolov2_ex.onnx';
exportONNXNetwork(net, filename);