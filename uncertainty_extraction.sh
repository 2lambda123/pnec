while getopts s: flag
do
    case "${flag}" in
        s) sequence=${OPTARG};;
    esac
done
: "${sequence:="04"}"
dataset_path="/storage/group/dataset_mirrors/kitti_odom_grey/sequences"
results_path="/storage/user/muhled/datasets/custom/kitti_patches"
no_skip="true"

tracking_config_path="data/tracking/KITTI"
tracking_calib_path="data/tracking/KITTI/kitti_calib.json"
config_path="data"
pnec_config="${config_path}/test_config.yaml"


tracking_path="${tracking_config_path}/${sequence}.json"
images_path="${dataset_path}/${sequence}/image_0"
timestamp_path="${dataset_path}/${sequence}/times.txt"
gt_path="${dataset_path}/${sequence}/poses.txt"

if [ "$sequence" = "00" ] || [ "$sequence" = "01" ] || [ "$sequence" = "02" ]
then
    camera_config="$config_path/config_kitti00-02.yaml"
fi
if [ "$sequence" = "03" ]
then
    camera_config="$config_path/config_kitti03.yaml"
fi
if [ "$sequence" = "04" ] || [ "$sequence" = "05" ] || [ "$sequence" = "06" ] || [ "$sequence" = "07" ] || [ "$sequence" = "08" ] || [ "$sequence" = "09" ] || [ "$sequence" = "10" ]
then
    camera_config="$config_path/config_kitti04-10.yaml"
fi

[ ! -d "$results_path/$sequence" ] && mkdir -p "$results_path/$sequence"

output="$results_path/$sequence/"

./build/uncertainty_extraction $camera_config $pnec_config $tracking_path $tracking_calib_path $images_path $gt_path $timestamp_path $output $no_skip