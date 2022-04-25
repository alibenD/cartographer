/*
 * Copyright 2016 The Cartographer Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <cmath>
#include <fstream>
#include <string>

#include "cartographer/common/port.h"
#include "cartographer/ground_truth/autogenerate_ground_truth.h"
#include "cartographer/ground_truth/proto/relations.pb.h"
#include "cartographer/io/proto_stream.h"
#include "cartographer/io/proto_stream_deserializer.h"
#include "cartographer/mapping/proto/pose_graph.pb.h"
#include "cartographer/transform/transform.h"

namespace cartographer {
namespace ground_truth {
namespace {

void Run(const std::string& pose_graph_filename,
         const std::string& output_filename, const double min_covered_distance,
         const double outlier_threshold_meters,
         const double outlier_threshold_radians) {
  //LOG(INFO) << "Reading pose graph from '" << pose_graph_filename << "'...";
  mapping::proto::PoseGraph pose_graph =
      io::DeserializePoseGraphFromFile(pose_graph_filename);

  //LOG(INFO) << "Autogenerating ground truth relations...";
  const proto::GroundTruth ground_truth =
      GenerateGroundTruth(pose_graph, min_covered_distance,
                          outlier_threshold_meters, outlier_threshold_radians);
  //LOG(INFO) << "Writing " << ground_truth.relation_size() << " relations to '"
  //          << output_filename << "'.";
#if 0
  {
    std::ofstream output_stream(output_filename,
                                std::ios_base::out | std::ios_base::binary);
    CHECK(ground_truth.SerializeToOstream(&output_stream))
        << "Could not serialize ground truth data.";
    output_stream.close();
    CHECK(output_stream) << "Could not write ground truth data.";
  }
#endif
}

}  // namespace
}  // namespace ground_truth
}  // namespace cartographer

int main(int argc, char** argv) {
  ::cartographer::ground_truth::Run("", "", 100, 0.15, 0.02);
}
